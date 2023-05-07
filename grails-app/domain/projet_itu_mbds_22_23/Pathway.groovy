package projet_itu_mbds_22_23

class Pathway {

    String title
    String description
    Date dateCreated
    Date lastUpdated
    List pois


    static hasMany = [pois: Poi,
                      illustrations: Illustration,
                      moderateurs: User]

    static belongsTo = [author: User]

    static constraints = {
        title nullable: false, blank: false, size: 5..55
        description nullable: false, blank: false
    }

    def isAuthor(User user){
        return author == user
    }

    def isModerators(User user){
        return moderateurs.contains(user);
    }

    def isAllowedToModifyPathway(User user){
        return (isAuthor(user) || isModerators(user));
    }

    def changePois(String[] poiIds){
        List poisTemp = new ArrayList(pois)
        pois.clear();
        for(String poiId : poiIds){
            for(Poi poi : poisTemp){
                if((poi.id + "") == poiId)
                    pois.add(poi)
            }
        }
    }

}
