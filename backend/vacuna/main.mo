import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Bool "mo:base/Bool";
import Int "mo:base/Int";
import Text "mo:base/Text";

actor {
    type Vacuna= {
        id : Int;
        dosis : Int;
        lote : Text;
        empresa : Text;
        fecha : Text;
        lugar : Text;
        tipo : Text;
        vigencia : Text;
    };

    type GetVacunaError = {
        #userNotAuthenticated;
        #vacunaNotFound;
    };

    type GetVacunaResponse = Result.Result<Vacuna, GetVacunaError>;

    type CreateVacunaError = {
        #vacunaAlreadyExists;
        #userNotAuthenticated;
    };

    type CreateVacunaResponse = Result.Result<Bool, CreateVacunaError>;

    let vacunas = HashMap.HashMap<Int, Vacuna>(0, Int.equal, Int.hash);

    public query ({caller}) func getVacuna (id : Int) : async GetVacunaResponse {

        let vacuna = vacunas.get(id);

        switch vacuna {
            case (?vacuna) {
                #ok(vacuna);
            };
            case null {
                #err(#vacunaNotFound);
            };
        }
    };

    public shared ({caller}) func createVacuna (id : Int, dosis : Int, lote : Text, empresa : Text, fecha : Text, lugar : Text,tipo : Text, vigencia : Text) : async CreateVacunaResponse {
        let vacuna = vacunas.get(id);
        if (vacuna != null) return #err(#vacunaAlreadyExists);

        let newVacuna: Vacuna = {
        id = id;
        dosis = dosis;
        lote = lote;
        empresa = empresa;
        fecha = fecha;
        lugar = lugar;
        tipo = tipo;
        vigencia = vigencia;
        };
        
        vacunas.put(id, newVacuna);

        #ok(true);
    };
}
