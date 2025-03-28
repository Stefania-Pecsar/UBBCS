from Domain.Entities import Carte
import os

def cauta_carte(lista,id,n):
    if n<0:
        raise ValueError("Id-ul nu a fost gasit")
    if lista[n-1].get_id()==id:
        return lista[n-1]
    return cauta_carte(lista,id,n-1)

class CarteRepo:
    def __init__(self):
        self.__carte=[]
        self.__id=0

    def adauga_carte(self,carte_noua):
        for carte in self.__carte:
            if carte.get_titlu() == carte_noua.get_titlu() and carte.get_autor() == carte_noua.get_autor():
                raise ValueError("Exista deja aceasta carte!")
        carte = Carte(carte_noua.get_id(),carte_noua.get_titlu(),carte_noua.get_autor(),carte_noua.get_descriere())
        self.__carte.append(carte)
        self.__id += 1

    def sterge_carte(self,id):
        carte_nou_lista=[]
        for carte in self.__carte:
            if carte.get_id()!=id:
                carte_nou_lista.append(carte)
        self.__carte=carte_nou_lista

    def modifica_carte(self,id,new_title,new_descriere,new_autor):
        new_book_list=[]
        ok = 0
        for carte in self.__carte:
            if carte.get_id()==id:
                carte.set_titlu(new_title)
                carte.set_descriere(new_descriere)
                carte.set_autor(new_autor)
                ok = 1
            new_book_list.append(carte)
        self.__carte=new_book_list
        if ok == 0:
            raise ValueError("Cartea nu a fost gasita!")

    def cauta_carte_dupa_id(self,id):
        return cauta_carte(self.__carte,id,len(self.__carte))

    def cauta_carte_dupa_parametru(self,  descriere):
        for carte in self.__carte:
            if carte.get_descriere()==descriere :
                return carte
        raise ValueError("Cartea nu a fost gasit")

    def cauta_id(self,id):
        ok=True
        for elem in self.__carte:
            if elem.get_id()==id:
                ok=False
        if ok:
            raise ValueError("Id-ul nu apartine niciunei carti")

    def get_all_books(self):
        return self.__carte

    def __eq__(self, other):
        return self.__carte==other.__carte

class CarteFileRepo(CarteRepo):
    def __init__(self,filename):
        CarteRepo.__init__(self)
        file = os.path.abspath(filename)
        self.__filename=file
        self.__load_from_file()

    def __load_from_file(self):
        with open(self.__filename,"r") as f:
            lines=f.readlines()
            for line in lines:
                if line=="\n":
                    break
                carte_id,carte_titlu,carte_autor,carte_descriere=[token.strip() for token in line.split(";")]
                carte=Carte(int(carte_id),carte_titlu,carte_autor,carte_descriere)
                CarteRepo.adauga_carte(self,carte)

    def __save_to_file(self):
        with open(self.__filename,"w") as f:
            carti=CarteRepo.get_all_books(self)
            for carte in carti:
                str_carte=str(carte.get_id())+";"+str(carte.get_titlu())+";"+str(carte.get_autor())+";"+str(carte.get_descriere())+"\n"
                f.write(str_carte)

    def adauga_carte(self,carte_noua):
        CarteRepo.adauga_carte(self,carte_noua)
        self.__save_to_file()

    def sterge_carte(self,id):
        CarteRepo.sterge_carte(self,id)
        self.__save_to_file()

    def modifica_carte(self,id,new_title,new_descriere,new_autor):
        CarteRepo.modifica_carte(self,id,new_title, new_descriere, new_autor)
        self.__save_to_file()

    def cauta_client_dupa_id(self,id):
        return CarteRepo.cauta_carte_dupa_id(self,id)

    def cauta_carte_dupa_parametru(self,titlu,descriere,autor):
        return CarteRepo.cauta_carte_dupa_parametru(self,titlu,descriere,autor)

    def cauta_id(self,id):
        return CarteRepo.cauta_id(self,id)

    def get_all_books(self):
        return CarteRepo.get_all_books(self)

    def __eq__(self, other):
        return CarteRepo.__eq__(self,other)