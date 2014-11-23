import processing.core.*;

String prefix = "And one"
String text = "And one day, when the wound burned violently, Siddhartha ferried across the river, driven by a yearning, got off the boat and was willing to go to the city and to look for his son. The river flowed softly and quietly, it was the dry season, but its voice sounded strange: it laughed! It laughed clearly. The river laughed, it laughed brightly and clearly at the old ferryman. Siddhartha stopped, he bent over the water, in order to hear even better, and he saw his face reflected in the quietly moving waters, and in this reflected face there was something, which reminded him, something he had forgotten, and as he thought about it, he found it: this face resembled another face, which he used to know and love and also fear. It resembled his father's face, the Brahman. And he remembered how he, a long time ago, as a young man, had forced his father to let him go to the penitents, how he had bed his farewell to him, how he had gone and had never come back. Had his father not also suffered the same pain for him, which he now suffered for his son? Had his father not long since died, alone, without having seen his son again? Did he not have to expect the same fate for himself? Was it not a comedy, a strange and stupid matter, this repetition, this running around in a fateful circle? ";
char[] chars = text.toCharArray();
PFont helvetica;

final String data_filename = "/home/sakekasi/Design/Processing/sketch6/data/siddhartha.markov";
final String text_filename = "/home/sakekasi/Design/Processing/sketch6/data/siddhartha.txt";
MarkovChain m_chain;

int textWidth=410, textHeight=380;

void setup(){
  m_chain = new MarkovChain();
  
  File siddhartha = new File(data_filename);
  if(!siddhartha.exists()){
    
    try{
      siddhartha.createNewFile();
    } catch (Exception e){
      e.printStackTrace();
    }
    
    m_chain.slurp(text_filename);
    m_chain.write(data_filename);
  } else {
    m_chain.read(data_filename);
  }
  
  frameRate(30);
  size(textWidth+145,textHeight+140);
  colorMode(HSB,360,100,100, 100);
  smooth();
  
  helvetica = loadFont("HelveticaNeue.vlw");
  textFont(helvetica, 15);
  textLeading(20);
  fill(255);
  
  background(0);
  
  text(text, 50,50,textWidth+50,textHeight+50);
}
