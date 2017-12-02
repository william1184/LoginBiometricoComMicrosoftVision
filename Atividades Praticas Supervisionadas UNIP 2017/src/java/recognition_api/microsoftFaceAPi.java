/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package recognition_api;
import java.io.InputStream;
import java.net.URI;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;

import org.apache.http.client.utils.URIBuilder;

import org.apache.http.entity.ContentType;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONArray;
import org.json.JSONObject;
/**
 *
 * @author Familia
 */
public class microsoftFaceAPi {

    // **********************************************
    // *** Update or verify the following values. ***
    // **********************************************

    // Replace the subscriptionKey string value with your valid subscription key.
    //MINHA CHAVE ÚNICA DO AZURE , VOU DEIXAR ILEGIVEL
    public static final String subscriptionKey = "YOUR-KEY-HERE";

    // Replace or verify the region.
    //
    // You must use the same region in your REST API call as you used to obtain your subscription keys.
    // For example, if you obtained your subscription keys from the westus region, replace
    // "westcentralus" in the URI below with "westus".
    //
    // NOTE: Free trial subscription keys are generated in the westcentralus region, so if you are using
    // a free trial subscription key, you should not need to change this region.
    public static final String detect = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/detect";
    public static final String verify = "https://brazilsouth.api.cognitive.microsoft.com/face/v1.0/verify";
    
    //MÉTODO CRIADO PARA ENVIAR E RECEBER O ID DA FACE DA PESSOA NO AZURE
    public static String getFaceDetection(InputStream imageByte){
        HttpClient httpclient = new DefaultHttpClient();
        try{
    
        URIBuilder builder = null;       
            builder = new URIBuilder(detect);       

            // Request parameters. All of them are optional.
            builder.setParameter("returnFaceId", "true");          

            // Prepare the URI for the REST API call.
            URI uri = builder.build();
            HttpPost request = new HttpPost(uri);

            // Request headers.
            request.setHeader("Content-Type", "application/octet-stream");
            request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

            // Request body.
             InputStreamEntity reqEntity = null;
//            StringEntity reqEntity = null;
            //AQUI ESTOU ENVIANDO A IMAGEM EM INPUTSTREAM MESMO.
            reqEntity = new InputStreamEntity(imageByte,-1,ContentType.APPLICATION_OCTET_STREAM);                    
            request.setEntity(reqEntity);
            // Execute the REST API call and get the response entity.
            HttpResponse response;        
            response = httpclient.execute(request);
            HttpEntity entity = response.getEntity();

            if (entity != null)
            {
                // Format and display the JSON response.
                System.out.println("REST Response:\n");
                String jsonString = EntityUtils.toString(entity).trim();
                //AQUI É O RETORNO DA API DA MICROSOFT
                if (jsonString.charAt(0) == '[') {
                    //ENTRA AQUI CASO A RESPOSTA  SEJA UM ARRAY
                    JSONArray jsonArray = new JSONArray(jsonString);
                    System.out.println("olá 1 " + jsonArray.toString(2));
                    return jsonArray.getJSONObject(0).get("faceId").toString();
                }
                else if (jsonString.charAt(0) == '{') {
                    //ENTRA AQUI CASO A RESPOSTA  SEJA UM OBJETO
                    JSONObject jsonObject = new JSONObject(jsonString);
                    System.out.println("olá 2 " + jsonObject.toString(2));
                    return "";
                } else {
                    //ENTRA CASO A RESPOSTA SEJA SOMENTE UMA STRING
                    System.out.println("Olá " + jsonString);
                    return "";
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return "nada";
    }
    //METODO CHAMADO LOGO DEPOIS OU ENVIO O FACE ID E RECEBO CONFIRMAÇÃO SE É IDENTICO OU NÃO.
    public static String getFaceVerify(String faceId,String personId){
        HttpClient httpclient = new DefaultHttpClient();
        try{
    
        URIBuilder builder = null;       
            builder = new URIBuilder(verify);        

            // Request parameters. All of them are optional.
            builder.setParameter("returnFaceId", "true");          
            
            // Prepare the URI for the REST API call.
            URI uri = builder.build();
            HttpPost request = new HttpPost(uri);

            // Request headers.
            request.setHeader("Content-Type", "application/json");
            request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

            // Request body.
            StringEntity reqEntity = null;
            //AQUI ENVIO UM JSON COM O FACE ID QUE GEREI ANTERIORMENTE E O PERSON ID QUE EU POSSUO NO AZURE, E O GROUP ID TAMBÉM.
            reqEntity = new StringEntity("{\"faceId\":\""+faceId+"\",\"personId\":\""+personId+"\",\"personGroupId\":\"aps_facial_recognition\"}");        
            request.setEntity(reqEntity);
            // Execute the REST API call and get the response entity.
            HttpResponse response;        
            response = httpclient.execute(request);        
            HttpEntity entity = response.getEntity();
            if (entity != null)
            {
                // Format and display the JSON response.
                System.out.println("REST Response:\n");
                //A RESPOSTA DA API
                String jsonString = EntityUtils.toString(entity).trim();
                if (jsonString.charAt(0) == '[') {
                     //ENTRA AQUI CASO A RESPOSTA  SEJA UM ARRAY
                    JSONArray jsonArray = new JSONArray(jsonString);
                    System.out.println("olá 1 " + jsonArray.toString(2));
                    return jsonArray.getJSONObject(0).get("isIdentical").toString();
                }
                else if (jsonString.charAt(0) == '{') {
                     //ENTRA AQUI CASO A RESPOSTA  SEJA UM OBJETO
                    JSONObject jsonObject = new JSONObject(jsonString);
                    System.out.println("olá 2 " + jsonObject.toString(2));
                    return jsonObject.get("isIdentical").toString();
                } else {
                     //ENTRA AQUI CASO A RESPOSTA  SEJA UMA STRING
                    System.out.println("Olá " + jsonString);
                    return jsonString;
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
         //RETORNO VAZIO CASO DÊ ALGUM ERRO
        return "";
    }
}
