import 'dart:async';
import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:intl/intl.dart';
import 'package:polymer_expressions/filter.dart';

import 'dafthtmlutil.dart';
import 'daftpolymerutil.dart';

/***
 * Colourful Countdown Timer Custom Element
 *
 * Upgraded through various versions of Polymer - shows a bit :-)
 *
 * Davy Mitchell - www.divingintodart.com
 *
 */
@CustomTag('clock-counter')
class ClockCounter extends PolymerElement {

  // Data
  Stopwatch watch;

  @observable
  DateTime startTime;
  DateTime endTime;

  int get elapsed => watch.elapsed.inSeconds;

  int cardpos = 300;
  int cardposResults = 300;

  Timer atimer;
  Timer animtimer;

  // Presentation
  @observable
  String nice_countdown;

  @observable
  int Limit = 60;

  DateFormat timeDisplayFormat;
  DivElement configCard;
  DivElement statusCard;
  DivElement resultCard;
  ButtonElement stopButton;
  NumberInputElement limitNumberInput;

  final Transformer asInteger = new StringToInt();

  /**
   * Created is the method to kick all things Polymer GUI.
   */
  ClockCounter.created() : super.created(){

    watch = new Stopwatch();
    timeDisplayFormat = new DateFormat("H:mm:ss");
    limitNumberInput = querySelector("#durationTextBox");

    atimer = new Timer.periodic(new Duration(milliseconds:1000), (Timer timer) => this.pulse());
    animtimer = new Timer.periodic(new Duration(milliseconds:20), (Timer timer) => this.anim());

  }

  /**
   * Element has been added to the DOM.
   */
  void enteredView(){

    super.enteredView();
    configCard = fromId(this, "#setupCard");
    statusCard = fromId(this, "#statusCard");
    stopButton = fromId(this, "#stopButton");
    resultCard = fromId(this, "#resultCard");
    limitNumberInput = fromId(this, "#durationTextBox");

    hideMe(statusCard);
    hideMe(resultCard);
  }

  /**
   * This method is the Tick-Tock of the clock.
   */
  void pulse() {

    if (!watch.isRunning) return;

    DateTime t = new DateTime(0).add(new Duration(seconds:elapsed));
    DateTime cd = new DateTime(0, 0, 0, 0, Limit).subtract(new Duration(seconds:elapsed));
    nice_countdown = timeDisplayFormat.format(cd);

    if (elapsed>Limit*60){
      stop();
      nice_countdown = "";
      hideMe(stopButton);
      showMe(resultCard);
    }
  }

  /**
   *  Start the Countdown.
   */
  void start(){

    startTime = new DateTime.now();
    watch.start();
    showMe(statusCard);
    hideMe(stopButton);
  }

  /**
   * Stop the Countdown.
   */
  void stop(){

    endTime = new DateTime.now();
    watch.stop();
    watch.reset();
    statusCard.style.top = "300px";
    hideMe(statusCard);
    hideMe(stopButton);
    nice_countdown = "";
  }

  /**
   * Hide the results card.
   */
  void hideTimeUp(){
    hideMe(resultCard);
  }

  /**
   * Animate the moving cards.
   */
  void anim(){

    if (youCanSeeMe(resultCard))
    {
      int tpos = intFromPx(resultCard);

      if (tpos>10)
      {
        cardposResults -= 10;
        resultCard.style.top = pxFromInt(cardposResults);
      }
      else {
        showMe(resultCard);
        cardposResults = 300;
      }
    }

    if (!watch.isRunning) return;

    if (youCanSeeMe(statusCard))
    {
      int tpos = intFromPx(statusCard);

      if (tpos>10)
      {
        cardpos -= 10;
        statusCard.style.top = pxFromInt(cardpos);
      }
      else {
        showMe(stopButton);
        cardpos = 300;
      }
    }

  }//anim

}

