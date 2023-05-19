<?php

namespace App\Controllers;

use \Core\View;

/**
 * Home controller
 *
 * PHP version 7.0
 */
class Timbre extends \Core\Controller
{

    use \App\Valider;

    private $original = [];
    private $error = [];
    private $required = [];
    private $donnees = [];

    public function nouveauAction()
    {
        $this->modifierAction();
    }

        /**
     * modifier une enchere
     *
     * @return void
     */
    public function supprimerAction()
    {
        $this->doitSauthentifier();

        $supprimerTimbre = \App\Models\Timbre::deleteOne($this->route_params['id']);

        if(empty($_GET["id_enchere"])){
            header('location: /enchere/index');
        }else{
            header('location: /enchere/details/' . $_GET["id_enchere"]);
        }
        exit;
    
    }

    /**
     * modifier une enchere
     *
     * @return void
     */
    public function modifierAction()
    {
        $this->doitSauthentifier();

        if(empty($this->route_params['id'])){
            $_POST['id_enchere'] = $_GET['id_enchere'];
            $this->chargerDonneesUtilisateur();
        }else{
            $this->original = \App\Models\Timbre::getOne($this->route_params['id']);
        }

        if($_SERVER['REQUEST_METHOD'] == 'POST'){

            $donneesLive = true;
            $this->validerChampsNonVide(['id_enchere', 'nom', 'tirage', 'largeur', 'longueur', 'id_etat', 'id_pays', 'date_de_creation' ]);
            $this->validerDate(['date_de_creation']);
            $this->validerText(['nom']);
            $this->validerIntPositif(['id_etat', 'id_pays', 'largeur', 'longueur', 'tirage', 'id_enchere']);
            $this->validerDbInt(['id_etat', 'id_pays']);
            if(empty($this->required) and empty($this->error)){

                    $id = \App\Models\Timbre::upsert([(empty($_POST['id']) ? null : $_POST['id']), $_POST['nom'], $_POST['tirage'], $_POST['largeur'], $_POST['longueur'], $_POST['certifie']??0, $_POST['id_enchere'], $_POST['id_etat'], $_POST['id_pays'], $_POST['est_principal']??0, $_POST['date_de_creation'], $_POST['id_enchere'], $_SESSION['id']]);

                if($id == false){
                    $this->error['creer'] = "Il y a un probleme sérieux";
                }else{
                    header('location: /enchere/details/' . $_POST['id_enchere']);
                    exit;
                }
            }
       
        }

        if(empty($this->route_params['id'])){
            $this->chargerDonneesApplication(['titre' => 'noveau timbre']);
        }

        $listePays = \App\Models\Timbre::listePays();
        $listeEtats = \App\Models\Timbre::listeEtat();
        View::renderTemplate('Timbre/form.html', ['donnees' => $this->donnees, 'error' => $this->error, 'required' => $this->required, 'original' => $this->original, 'listepays' => $listePays, 'listeetats' => $listeEtats]);
    }

}
