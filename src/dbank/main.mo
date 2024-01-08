import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor Dbank{
  stable var currentValue: Float = 300;
  currentValue := 100;

  stable var startTime = Time.now();
  let id  = 2342345;

  Debug.print(debug_show(currentValue));

  public func topUp(amount: Float) {
    currentValue+=amount;
    Debug.print(debug_show(currentValue));
  };
  
  public func withDraw(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if ( tempValue>= 0){
      currentValue-=amount;
      Debug.print(debug_show(currentValue));
    }
    else{
      Debug.print("Not sufficieant amount to withdraw")
    }
    
  };

  public query func checkBalance(): async Float{
    return currentValue;
  };

  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS/1000000000;
    currentValue:= currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
};
