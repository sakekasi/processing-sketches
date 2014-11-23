import processing.core.*;

import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Queue;
import java.util.ArrayDeque;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.ObjectOutputStream;
import java.io.ObjectInputStream;

public class MarkovChain {
  private static final int PREFIX_LENGTH = 2;

  private Map<String, ArrayList<String>> data;
  
  public MarkovChain(){
    this.data = new HashMap<String, ArrayList<String>>();
  }

  public void slurp(String filename) {
    String lines[] = loadStrings(filename);

    String[] prefix = null;
    for (String line : lines) {
      prefix = this.addLine(prefix, line);
    }
  }
  
  public void write(String filename){
    File file = new File(filename);
    
    try{
      FileOutputStream fos = new FileOutputStream(file, false);
      ObjectOutputStream oos = new ObjectOutputStream(fos);
      
      oos.writeObject(this.data);
   
      oos.close();
    } catch (Exception e){
      e.printStackTrace();
    }
  }
  
  public void read(String filename){
    File file = new File(filename);
    
    try{
      FileInputStream fis = new FileInputStream(file);
      ObjectInputStream ois = new ObjectInputStream(fis);
      
      this.data = (HashMap<String, ArrayList<String>>) ois.readObject();
      
      ois.close();
    } catch (Exception e){
      e.printStackTrace();
    }
  }
  
  public String generate(String[] prefix, int len){
    if(!data.containsKey(join(prefix, " "))){
      return "";
    }
    
    ArrayList<String> text = new ArrayList<String>();
    for(String word: prefix){
      text.add(word);
    }
    
    len -= prefix.length;
    while(len > 0){
      String key = text.get(text.size()-2)+ " " + text.get(text.size()-1);
      ArrayList<String> val = this.data.get(key);
      
      text.add(val.get((int) random(val.size())));
      len--;
    }
    
    return join(text.toArray(new String[0]), " ");
  }
  
  public String next(String prefix){
    if(prefix == null || !this.data.containsKey(prefix)){
      return null;
    }
    ArrayList<String> val = this.data.get(prefix);
    return val.get((int) random(val.size()));
  }
    
  private String[] addLine(String[] prefix, String line){
    String[] words = line.split(" ");
    Queue<String> cur_prefix = new ArrayDeque<String>();
    int i = 0;
    
    if(words.length < PREFIX_LENGTH && prefix == null){
      if(words.length > 0){
        return words;
      } else {
        return null;
      }
    } else if (prefix.length < PREFIX_LENGTH && words.length <= (PREFIX_LENGTH-prefix.length)){
      for(String word: prefix){
        cur_prefix.add(word);
      }
      for(String word: words){
        cur_prefix.add(word);
      }
      
      return cur_prefix.toArray(new String[0]);
    } else if(prefix.length < PREFIX_LENGTH && words.length > (PREFIX_LENGTH-prefix.length)){
      i = PREFIX_LENGTH-prefix.length;
      for(String word: prefix){
        cur_prefix.add(word);
      }
      for(int j = 0; j<PREFIX_LENGTH-prefix.length; j++){
        cur_prefix.add(words[j]);
      }
    } else if(prefix == null){ //we're at the first line
      i = PREFIX_LENGTH;
      for(int j=0; j<PREFIX_LENGTH; j++){
        cur_prefix.add(words[j]);
      }
    } else {
      for(String word: prefix){
        cur_prefix.add(word);
      }
    }
    
    for(; i<words.length; i++){
      String key = join(cur_prefix.toArray(new String[0]), " ");
      ArrayList<String> val;
      
      if(this.data.containsKey(key)){
        val = this.data.get(key);
      } else {
        val = new ArrayList<String>();
        this.data.put(key, val);
      }
      
      val.add(words[i]);
      
      cur_prefix.add(words[i]);
      cur_prefix.remove();
    }
    
    return cur_prefix.toArray(new String[0]);
  }  
}

