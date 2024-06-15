import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Result "mo:base/Result";
import Bool "mo:base/Bool";
import Int "mo:base/Int";

actor {
    type Profile = {
        id : Int;
        edad : Int;
        id_registro : Int;
    };

    type GetProfileError = {
        #userNotAuthenticated;
        #profileNotFound;
    };

    type GetProfileResponse = Result.Result<Profile, GetProfileError>;

    type CreateProfileError = {
        #profileAlreadyExists;
        #userNotAuthenticated;
    };

    type CreateProfileResponse = Result.Result<Bool, CreateProfileError>;

    let profiles = HashMap.HashMap<Principal, Profile>(0, Principal.equal, Principal.hash);

    public query ({caller}) func getProfile () : async GetProfileResponse {
        if (Principal.isAnonymous(caller)) return #err(#userNotAuthenticated);

        let profile = profiles.get(caller);

        switch profile {
            case (?profile) {
                #ok(profile);
            };
            case null {
                #err(#profileNotFound);
            };
        }
    };

    public shared ({caller}) func createProfile (id : Int, edad : Int, id_registro : Int) : async CreateProfileResponse {
        if (Principal.isAnonymous(caller)) return #err(#userNotAuthenticated);

        let profile = profiles.get(caller);

        if (profile != null) return #err(#profileAlreadyExists);

        let newProfile: Profile = {
            id = id;
            edad = edad;
            id_registro = id_registro;
        };
        
        profiles.put(caller, newProfile);

        #ok(true);
    };
}
