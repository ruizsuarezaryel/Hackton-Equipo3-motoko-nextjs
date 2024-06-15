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
        aplicado : Bool;
        detalle : Int;
    };

    

    public shared ({caller}) func relacionarVacuna(idVacuna : Int) : async Int {
               
        let vacuna = actor("vacbr5f7-7uaaa-aaaaa-qaaca-cai"): actor { getValueId: (id : Int) -> async  Int};
     

        return await vacuna.getValueId(idVacuna);

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

    
    public shared ({caller}) func createCartilla (curp : Text, vacuna: Text, enfermedades : Text, rangoEdad: Text, frecuencia: Text,  fecha : Text, aplicado : Bool, detalle : Int) : async CreateCartillaResponse {
        
        let cartilla = cartillas.get(curp);

        if (cartilla != null) return #err(#primerAlreadyExists);

        let newCartilla: Cartilla = {
            vacuna = vacuna;
            curp = curp;
            enfermedades = enfermedades;
            rangoEdad = rangoEdad;
            frecuencia = frecuencia;
            fecha = fecha;
            aplicado = aplicado;
            detalle = detalle;

        };
        
        cartillas.put(curp, newCartilla);

        #ok(true);
    };
}