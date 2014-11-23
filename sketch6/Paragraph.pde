import processing.core.*;

import java.util.ArrayList;
import java.util.Arrays;

public class Paragraph {
  final String dir = "/home/sakekasi/Design/processing-sketches/sketch6/data/";
  final String data_extension = ".markov";
  final String text_extension = ".txt";

  private ArrayList<String> words;
  private MarkovChain m_chain;

  public Paragraph(String title, String text) {
    words = new ArrayList<String>(Arrays.asList(text.split(" ")));
    
    String data_filename = dir + title + data_extension;
    String text_filename = dir + title + text_extension;

    this.m_chain = new MarkovChain();
    
    File siddhartha = new File(data_filename);
    if (!siddhartha.exists()) {

      try {
        siddhartha.createNewFile();
      } 
      catch (Exception e) {
        e.printStackTrace();
      }

      m_chain.slurp(text_filename);
      m_chain.write(data_filename);
    } else {
      m_chain.read(data_filename);
    }
  }

  public void swap() {
    int i = (int) random(2, words.size());

    String prefix = words.get(i-2) + " " + words.get(i-1);
    String next = m_chain.next(prefix);
    if(next != null){
      words.set(i, next);
    }
  }

  public String toString() {
    return join(this.words.toArray(new String[0]), " ");
  }
}

