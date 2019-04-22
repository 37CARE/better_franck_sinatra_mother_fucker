# LA CLASSE GOSSIP EST LA CLASSE QUI INTERAGIT AVEC LA BASE DE DONNÉES
# CHAQUE METHODE VA INTERAGIRE AVEC LE FICHIER CSV

class Gossip
    # Un Gossip se definit par un auteur et du contenu
    attr_accessor :author, :content
    # ON DEFINIT LA VARIABLE DU FICHIER CSV
    @@FILE_NAME = "./db/gossip.csv"
#   ON INITIALISE LES DEUX ATTRIBUTS
    def initialize(author, content)
      @content = content
      @author = author
    end
#   ON SAUVEGARDE LE HASH DANS UN ARRAY DANS LE FICHIER QU'ON A OUVERT EN ÉCRITURE À PARTIR DE LA FIN "AB"
    def save_gossip
      CSV.open(@@FILE_NAME, "ab") {|csv|
        csv << [@author, @content]
      }
    end
  
    def self.index_gossips
      CSV.read("./db/gossip.csv")
    end
  
    # POUR AFFICHER TOUS LES GOSSIPS DEPUIS LE DERNIER GOSSIP, CSV FROM BOTTOM TO TOP
    def self.all
      all_gossips = []
      CSV.read("./db/gossip.csv").reverse.each do |csv_line|
        all_gossips << Gossip.new(csv_line[0], csv_line[1])
      end
      return all_gossips
    end
  
    # POUR RETOURNER LE GOSSIP À PARTIR DE SON ID, SI L'ID DE L'URL NE CORRESPOND À AUCUN GOSSIP LA METHODE RETOURNE UN MESSAGE D'ERREUR
    def self.find(id)
     all_gossips = []
     CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    id = id.to_i
    if id <= all_gossips.length && id > 0
      return all_gossips[id-1]
    else
      return "PAS DE GOSSIP ICI MON POULET!"
    end
  end
  
#   METHODE QUI PERMET D'UPDATE UN GOSSIP
  def self.update(_author, _content, _id)
    _id =_id.to_i
    all_gossips = all
    all_gossips[_id-1].author=_author
    all_gossips[_id-1].content=_content
    save_all_gossips(all_gossips)
  end
  
  def self.save_all_gossips(_gossips)
    File.open(@@FILE_NAME, 'w') {|file| file.truncate(0) }
    _gossips.each { |gossip|
      CSV.open(@@FILE_NAME, "ab") {|csv|
        csv << [gossip.author, gossip.content]
      }
    }
  end
  
  
  end