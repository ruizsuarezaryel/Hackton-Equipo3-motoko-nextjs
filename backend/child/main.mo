import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Text "mo:base/Text";
import Bool "mo:base/Bool";
import Int "mo:base/Int";


actor {
    type Child = {
        curp : Text;
        edad : Int;
        id_registro : Int;
    };

    type GetChildError = {
        #ChildNotFound;
    };

    type GetChildResponse = Result.Result<Child, GetChildError>;

    type CreateChildError = {
        #ChildAlreadyExists;
    };

    type CreateChildResponse = Result.Result<Bool, CreateChildError>;

    let Childs = HashMap.HashMap<Text, Child>(0, Text.equal, Text.hash);

    public query ({caller}) func getChild (curp : Text) : async GetChildResponse {

        let Child = Childs.get(curp);

        switch Child {
            case (?Child) {
                #ok(Child);
            };
            case null {
                #err(#ChildNotFound);
            };
        }
    };

    public shared ({caller}) func createChild (curp : Text, edad : Int, id_registro : Int) : async CreateChildResponse {

        let Child = Childs.get(curp);

        if (Child != null) return #err(#ChildAlreadyExists);

        let newChild: Child = {
            curp = curp;
            edad = edad;
            id_registro = id_registro;
        };
        
        Childs.put(curp, newChild);

        #ok(true);
    };
}
