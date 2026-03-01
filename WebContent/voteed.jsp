<%-- 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>

<%@ page import="org.json.JSONObject" %>

<%@ page import="com.amazonaws.auth.AWSStaticCredentialsProvider" %>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials" %>
<%@ page import="com.amazonaws.client.builder.AwsClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3ClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.model.ObjectMetadata" %>
<%@ page import="com.amazonaws.services.s3.model.PutObjectRequest" %>

<%@ page import="org.web3j.protocol.Web3j" %>
<%@ page import="org.web3j.protocol.http.HttpService" %>
<%@ page import="org.web3j.crypto.Credentials" %>
<%@ page import="org.web3j.crypto.RawTransaction" %>
<%@ page import="org.web3j.crypto.TransactionEncoder" %>
<%@ page import="org.web3j.protocol.core.methods.response.EthSendTransaction" %>
<%@ page import="org.web3j.protocol.core.DefaultBlockParameterName" %>
<%@ page import="org.web3j.utils.Numeric" %>

<%@ page import="dbcon.dbconn" %>

<%

final String FILEBASE_KEY = "9AED1223862989DD6BE1";
final String FILEBASE_SECRET = "5mxSXGVbqHbTYtTgzxari6hvXf34e0I026MaN0yH";
final String FILEBASE_S3_ENDPOINT = "https://s3.filebase.com";
final String FILEBASE_BUCKET = "blockchainprismkyc";
final String GANACHE_URL = "http://192.168.1.49:7545";
final String PRIVATE_KEY = "0xa9b88ed8155d97cfd0954d64a27762d9ebc0b04753012184173edc1b36d5a2b9";


String cname = request.getParameter("cname");
String cemail = request.getParameter("cemail");
String dis = request.getParameter("dis");
String mail = request.getParameter("mail");


if (cname == null || cemail == null) {
    response.sendRedirect("Error.jsp?error=Missing+parameters");
    return;
}

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

int generatedId = -1;

byte[] blobpic = null;
byte[] blobsymbol = null;


try {
    con = dbconn.create();
    ps = con.prepareStatement("SELECT * FROM studentvoute.eligible WHERE email = ?");
    ps.setString(1, cemail);
    rs = ps.executeQuery();
    if (rs.next()) {
        blobpic = rs.getBytes(2);      
        blobsymbol = rs.getBytes(6);  
    }
    if (rs != null) rs.close();
    if (ps != null) ps.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=DB+eligible+fetch+failed");
    return;
}


String prehash = "";
String afterhash = "";

try {
    ps = con.prepareStatement("SELECT phash, ahash FROM studentvoute.votes WHERE mail = ? ORDER BY id DESC LIMIT 1");
    ps.setString(1, "vote");
    rs = ps.executeQuery();
    if (rs.next()) {
        prehash = rs.getString(1);
        afterhash = rs.getString(2);
    }
    if (rs != null) rs.close();
    if (ps != null) ps.close();
} catch (Exception e) {
    
}


if (afterhash != null && !afterhash.isEmpty()) {
    prehash = afterhash;
}


String phas = "";
String aphas = "";
try {
    Bean.Block genesisBlock = new Bean.Block("VoteBlockGenesis", "0");
    phas = genesisBlock.hash;
    Bean.Block secondBlock = new Bean.Block("VoteBlockNext", genesisBlock.hash);
    aphas = secondBlock.hash;
} catch (Exception e) {
  
    phas = String.valueOf(System.currentTimeMillis());
    aphas = String.valueOf(System.currentTimeMillis() + 1);
}


int insertedRows = 0;
try {
    
    ps = con.prepareStatement(
        "INSERT INTO studentvoute.votes VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
        Statement.RETURN_GENERATED_KEYS
    );

    ps.setString(1, cname);
    ps.setBytes(2, blobpic);
    ps.setString(3, dis);
    ps.setString(4," ");
    ps.setString(5, "Voted");
    ps.setString(6, prehash);
    ps.setString(7, aphas);
    ps.setString(8, cemail);
    ps.setString(9, mail);
    ps.setBytes(10, blobsymbol);
    ps.setString(11, "");
    ps.setString(12, "");
    ps.setString(13, " ");

    insertedRows = ps.executeUpdate();

    rs = ps.getGeneratedKeys();
    if (rs.next()) {
        generatedId = rs.getInt(1);
    }
    if (rs != null) rs.close();
    ps.close();

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Insert+vote+failed");
    return;
}

if (insertedRows <= 0 || generatedId == -1) {
    response.sendRedirect("Error.jsp?error=Insert+vote+failed+or+no+id");
    return;
}


String cid = null;
try {
    JSONObject voteJson = new JSONObject();
    voteJson.put("id", generatedId);
    voteJson.put("cname", cname);
    voteJson.put("cemail", cemail);
    voteJson.put("district", dis);
    voteJson.put("mail", mail);
    voteJson.put("phash", phas);
    voteJson.put("ahash", aphas);

    String jsonString = voteJson.toString();

    
    BasicAWSCredentials awsCreds = new BasicAWSCredentials(FILEBASE_KEY, FILEBASE_SECRET);
    AwsClientBuilder.EndpointConfiguration endpoint = new AwsClientBuilder.EndpointConfiguration(FILEBASE_S3_ENDPOINT, "us-east-1");

    AmazonS3 s3 = AmazonS3ClientBuilder.standard()
                    .withEndpointConfiguration(endpoint)
                    .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                    .withPathStyleAccessEnabled(true)
                    .build();

    String objectKey = "vote_" + generatedId + ".json";

    byte[] contentBytes = jsonString.getBytes("UTF-8");
    InputStream input = new ByteArrayInputStream(contentBytes);
    ObjectMetadata metadata = new ObjectMetadata();
    metadata.setContentType("application/json");
    metadata.setContentLength(contentBytes.length);

    PutObjectRequest putReq = new PutObjectRequest(FILEBASE_BUCKET, objectKey, input, metadata);
    s3.putObject(putReq);

    
    try {
        ObjectMetadata meta = s3.getObjectMetadata(FILEBASE_BUCKET, objectKey);
       
        String ipfsCid = meta.getUserMetaDataOf("ipfs-hash");      
        if (ipfsCid == null) ipfsCid = meta.getUserMetaDataOf("cid");
        if (ipfsCid == null) ipfsCid = meta.getUserMetaDataOf("x-amz-meta-ipfs-hash");
        if (ipfsCid == null) ipfsCid = meta.getUserMetaDataOf("x-amz-meta-cid");

        if (ipfsCid != null && !ipfsCid.trim().isEmpty()) {
            cid = ipfsCid;
        } else {
            
            cid = objectKey;
        }
    } catch (Exception e) {
        
        cid = objectKey;
    }

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Filebase+upload+failed");
    return;
}


String txHash = null;
String senderAddress = null;
try {
    Web3j web3 = Web3j.build(new HttpService(GANACHE_URL));
    Credentials creds = Credentials.create(PRIVATE_KEY);
    senderAddress = creds.getAddress();


    BigInteger nonce = web3.ethGetTransactionCount(senderAddress, DefaultBlockParameterName.PENDING)
                          .send()
                          .getTransactionCount();

   
    BigInteger gasPrice = web3.ethGasPrice().send().getGasPrice();
    BigInteger gasLimit = BigInteger.valueOf(300_000); 


    byte[] cidBytes = cid.getBytes("UTF-8");
    String cidHex = Numeric.toHexString(cidBytes);

    
    RawTransaction raw = RawTransaction.createTransaction(
            nonce,
            gasPrice,
            gasLimit,
            senderAddress,
            BigInteger.ZERO,
            cidHex
    );

    byte[] signedMessage = TransactionEncoder.signMessage(raw, creds);
    String hexValue = Numeric.toHexString(signedMessage);

    EthSendTransaction ethSend = web3.ethSendRawTransaction(hexValue).send();

    if (ethSend.getError() != null) {
        System.err.println("Ganache tx error: " + ethSend.getError().getMessage());
        response.sendRedirect("Error.jsp?error=Ganache+tx+error");
        return;
    }

    txHash = ethSend.getTransactionHash();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Ganache+transaction+failed");
    return;
}


try {
    ps = con.prepareStatement("UPDATE studentvoute.votes SET cid = ?, txhash = ?, sender_addr = ? WHERE id = ?");
    ps.setString(1, cid);
    ps.setString(2, txHash);
    ps.setString(3, senderAddress);
    ps.setInt(4, generatedId);
    ps.executeUpdate();
    if (ps != null) ps.close();
} catch (Exception e) {
    e.printStackTrace();
   
}


response.sendRedirect("votesucessfully.jsp?id=" + generatedId + "&cid=" + cid + "&tx=" + txHash);
%>
 --%>
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="org.json.JSONObject" %>

<%@ page import="com.amazonaws.auth.*" %>
<%@ page import="com.amazonaws.client.builder.AwsClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.*" %>
<%@ page import="com.amazonaws.services.s3.model.*" %>

<%@ page import="org.web3j.protocol.*" %>
<%@ page import="org.web3j.protocol.http.HttpService" %>
<%@ page import="org.web3j.crypto.*" %>
<%@ page import="org.web3j.protocol.core.*" %>
<%@ page import="org.web3j.utils.Numeric" %>

<%@ page import="dbcon.dbconn" %>

<%
/* ================= CONFIG ================= */
final String FILEBASE_KEY = "876CDEC5E046E1D84236";
final String FILEBASE_SECRET = "4NC65morpDHnpv9J5nH4sAE2JG98EIsklkmMrTaj";
final String FILEBASE_S3_ENDPOINT = "https://s3.filebase.com";
final String FILEBASE_BUCKET = "rental";
final String GANACHE_URL = "HTTP://192.168.1.35:7545";
final String PRIVATE_KEY = "0x93fd04e8e9f1303d33e9e192255397f50f73a769d3ca9914f5cd96f7306ba694";
/* ========================================== */

/* ====== INPUT ====== */
String cname  = request.getParameter("cname");
String cemail = request.getParameter("cemail");
String dept    = request.getParameter("dept");
String mail   = request.getParameter("mail");

if (cname == null || cemail == null) {
    response.sendRedirect("Error.jsp?error=Missing+parameters");
    return;
}

/* ====== DB ====== */
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

byte[] blobpic = null;
byte[] blobsymbol = null;

try {
    con = dbconn.create();

    ps = con.prepareStatement(
        "SELECT image, symbol FROM studentvoute.eligible WHERE email=?"
    );
    ps.setString(1, cemail);
    rs = ps.executeQuery();

    if (rs.next()) {
        blobpic = rs.getBytes(1);
        blobsymbol = rs.getBytes(2);
    }

    rs.close();
    ps.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Eligible+fetch+failed");
    return;
}

/* ===== HASH ===== */
String prehash = "0";
String aphash = String.valueOf(System.currentTimeMillis());

/* ===== INSERT VOTE (FIXED) ===== */
int voteId = -1;

try {
    ps = con.prepareStatement(
        "INSERT INTO studentvoute.votes " +
        "(crollnum, blobpic,dept, course, status, phash, ahash, cemail, mail, Blobsymol, cid, txhash, sender_addr) " +
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)",
        Statement.RETURN_GENERATED_KEYS
    );

    ps.setString(1, cname);
    ps.setBytes(2, blobpic);
    ps.setString(3, dept);
    ps.setString(4, " ");
    ps.setString(5, "Voted");
    ps.setString(6, prehash);
    ps.setString(7, aphash);
    ps.setString(8, cemail);
    ps.setString(9, mail);
    ps.setBytes(10, blobsymbol);
    ps.setString(11, "");
    ps.setString(12, "");
    ps.setString(13, "");

    ps.executeUpdate();

    rs = ps.getGeneratedKeys();
    if (rs.next()) {
        voteId = rs.getInt(1);
    }

    rs.close();
    ps.close();
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("Error.jsp?error=Vote+insert+failed");
    return;
}

/* ===== JSON + FILEBASE ===== */
String cid = null;

try {
    JSONObject obj = new JSONObject();
    obj.put("id", voteId);
    obj.put("cname", cname);
    obj.put("cemail", cemail);
    obj.put("department", dept);
    obj.put("mail", mail);
    obj.put("phash", prehash);
    obj.put("ahash", aphash);

    byte[] data = obj.toString().getBytes("UTF-8");

    AmazonS3 s3 = AmazonS3ClientBuilder.standard()
        .withEndpointConfiguration(
            new AwsClientBuilder.EndpointConfiguration(FILEBASE_S3_ENDPOINT, "us-east-1"))
        .withCredentials(new AWSStaticCredentialsProvider(
            new BasicAWSCredentials(FILEBASE_KEY, FILEBASE_SECRET)))
        .withPathStyleAccessEnabled(true)
        .build();

    ObjectMetadata meta = new ObjectMetadata();
    meta.setContentLength(data.length);
    meta.setContentType("application/json");

    String key = "vote_" + voteId + ".json";
    s3.putObject(FILEBASE_BUCKET, key, new ByteArrayInputStream(data), meta);
    cid = key;

} catch (Exception e) {
    e.printStackTrace();
}

/* ===== GANACHE ===== */
String txHash = null;
String senderAddr = null;

try {
    Web3j web3 = Web3j.build(new HttpService(GANACHE_URL));
    Credentials creds = Credentials.create(PRIVATE_KEY);
    senderAddr = creds.getAddress();

    BigInteger nonce = web3.ethGetTransactionCount(
        senderAddr, DefaultBlockParameterName.PENDING).send().getTransactionCount();

    RawTransaction raw = RawTransaction.createTransaction(
        nonce,
        web3.ethGasPrice().send().getGasPrice(),
        BigInteger.valueOf(300000),
        senderAddr,
        BigInteger.ZERO,
        Numeric.toHexString(cid.getBytes())
    );

    byte[] signed = TransactionEncoder.signMessage(raw, creds);
    txHash = web3.ethSendRawTransaction(
        Numeric.toHexString(signed)).send().getTransactionHash();

} catch (Exception e) {
    e.printStackTrace();
}

/* ===== UPDATE TX ===== */
try {
    ps = con.prepareStatement(
        "UPDATE studentvoute.votes SET cid=?, txhash=?, sender_addr=? WHERE id=?"
    );
    ps.setString(1, cid);
    ps.setString(2, txHash);
    ps.setString(3, senderAddr);
    ps.setInt(4, voteId);
    ps.executeUpdate();
    ps.close();
} catch (Exception e) {
    e.printStackTrace();
}

response.sendRedirect(
    "votesucessfully.jsp?id=" + voteId + "&cid=" + cid + "&tx=" + txHash
);
%>
 