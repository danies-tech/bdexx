import OrderedMap "mo:base/OrderedMap";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Iter "mo:base/Iter";

actor VeriMesh {
  transient let textMap = OrderedMap.Make<Text>(Text.compare);

  var walletConnections : OrderedMap.Map<Text, Time.Time> = textMap.empty();
  var validationRequests : OrderedMap.Map<Text, Time.Time> = textMap.empty();

  public func recordWalletConnection(walletAddress : Text) : async () {
    let timestamp = Time.now();
    walletConnections := textMap.put(walletConnections, walletAddress, timestamp);
  };

  public func recordValidationRequest(walletAddress : Text) : async () {
    let timestamp = Time.now();
    validationRequests := textMap.put(validationRequests, walletAddress, timestamp);
  };

  public query func getWalletConnections() : async [(Text, Time.Time)] {
    Iter.toArray(textMap.entries(walletConnections));
  };

  public query func getValidationRequests() : async [(Text, Time.Time)] {
    Iter.toArray(textMap.entries(validationRequests));
  };
};
