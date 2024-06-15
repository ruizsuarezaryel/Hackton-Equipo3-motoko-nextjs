import Principal "mo:base/Principal";
import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Bool "mo:base/Bool";



actor {
    type Cartilla = {
        vacuna : Text;
        curp: Text;
        enfermedades : Text;
        rangoEdad : Text;
        frecuencia : Text;
        fecha : Text;
    };

    type GetProfileError = {
        #primerNotFound;
    };

    type GetCartillaResponse = Result.Result<Cartilla, GetProfileError>;

    type CreateProfileError = {
        #primerAlreadyExists;
    };
    
    type CreateCartillaResponse = Result.Result<Bool, CreateProfileError>;

    let cartillas = HashMap.HashMap<Text, Cartilla>(0, Text.equal, Text.hash);

    public query ({caller}) func getCartilla (curp : Text) : async GetCartillaResponse {
        
        
        let cartilla = cartillas.get(curp);

        switch cartilla {
            case (?cartilla) {
                #ok(cartilla);
            };
            case null {
                #err(#primerNotFound);
            };
        }
        
    };

    
    public shared ({caller}) func createCartilla (curp : Text, vacuna: Text, enfermedades : Text, rangoEdad: Text, frecuencia: Text,  fecha : Text) : async CreateCartillaResponse {
        
        let cartilla = cartillas.get(curp);

        if (cartilla != null) return #err(#primerAlreadyExists);

        let newCartilla: Cartilla = {
            vacuna = vacuna;
            curp = curp;
            enfermedades = enfermedades;
            rangoEdad = rangoEdad;
            frecuencia = frecuencia;
            fecha = fecha;
        };
        
        cartillas.put(curp, newCartilla);

        #ok(true);
    };
}