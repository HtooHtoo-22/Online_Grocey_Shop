package project.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;

public class BlankProfilePhoto {
	    public static byte[] getMalePhotoByte() throws IOException {
	    	File file = new File("C:\\Users\\HtooHtoo\\Pictures\\Download\\male.jpg");
	        FileInputStream fis = new FileInputStream(file);
	        byte[] byteArray = new byte[(int) file.length()];
	        
	        // Read file into byte array
	        fis.read(byteArray);
	        fis.close();
	        
	        return byteArray;
	    }
	    public static byte[] getFemalePhotoByte() throws IOException {
	    	File file = new File("C:\\Users\\HtooHtoo\\Pictures\\Download\\female.jfif");
	        FileInputStream fis = new FileInputStream(file);
	        byte[] byteArray = new byte[(int) file.length()];
	        fis.read(byteArray);
	        fis.close();
	        
	        return byteArray;
	    }
	    
	    public static String getMalePhoto() throws IOException {
	        File file = new File("C:\\Users\\HtooHtoo\\Pictures\\Download\\male.jpg");
	        FileInputStream fis = new FileInputStream(file);
	        byte[] byteArray = new byte[(int) file.length()];

	        // Read file into byte array
	        fis.read(byteArray);
	        fis.close();

	        // Convert byte array to Base64-encoded string
	        return Base64.getEncoder().encodeToString(byteArray);
	    }
	    public static String getFemalePhoto() throws IOException {
	        File file = new File("C:\\Users\\HtooHtoo\\Pictures\\Download\\female.jfif");
	        FileInputStream fis = new FileInputStream(file);
	        byte[] byteArray = new byte[(int) file.length()];
	        fis.read(byteArray);
	        fis.close();

	        // Convert byte array to Base64-encoded string
	        return Base64.getEncoder().encodeToString(byteArray);
	    }
	    public static String getBase64(byte[]b) {
	    	return Base64.getEncoder().encodeToString(b);
	    }
	    public static byte[] chooseProfile(String photo,String gender) throws IOException {
	    	if(photo!=null && !photo.isEmpty()) {
	    		return Base64.getDecoder().decode(photo);
			}else if(gender.equals("male")) {
				return BlankProfilePhoto.getMalePhotoByte();
			}else if(gender.equals("female")) {
				return BlankProfilePhoto.getFemalePhotoByte();
			}else {
				System.out.println("hahaha");
				return null;
			}
	    }
	}

