CREATE OR REPLACE FUNCTION calculer_longueur_max(chaine1 TEXT, chaine2 TEXT)
RETURNS INTEGER AS $$
DECLARE
	longueur_chaine1 INTEGER;
	longueur_chaine2 INTEGER;
	longueur_max INTEGER;
BEGIN
	longueur_chaine1 := LENGTH(chaine1);
	longueur_chaine2 := LENGTH(chaine2);
    
	IF longueur_chaine1 >= longueur_chaine2 THEN
    	longueur_max := longueur_chaine1;
	ELSE
    	longueur_max := longueur_chaine2;
	END IF;

	RETURN longueur_max;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nb_occurrences_v1(
	carac CHAR,
	chaine TEXT,
	debut INTEGER,
	fin INTEGER
)
RETURNS INTEGER AS $$
DECLARE
	nb_occurrences INTEGER := 0;
BEGIN
	IF debut < 1 OR fin > LENGTH(chaine) OR debut > fin THEN
    	RAISE EXCEPTION 'Intervalle invalide';
	END IF;

	FOR i IN debut-1..fin-1 LOOP
    	IF SUBSTR(chaine, i+1, 1) = carac THEN
        	nb_occurrences := nb_occurrences + 1;
    	END IF;
	END LOOP;

	RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nb_occurrences_v2(
	carac CHAR,
	chaine TEXT,
	debut INTEGER,
	fin INTEGER
)
RETURNS INTEGER AS $$
DECLARE
	nb_occurrences INTEGER := 0;
	i INTEGER := debut - 1;
BEGIN
	IF debut < 1 OR fin > LENGTH(chaine) OR debut > fin THEN
    	RAISE EXCEPTION 'Intervalle invalide';
	END IF;

	LOOP
    	EXIT WHEN i >= fin;

    	IF SUBSTR(chaine, i+1, 1) = carac THEN
        	nb_occurrences := nb_occurrences + 1;
    	END IF;

    	i := i + 1;
	END LOOP;

	RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION nb_occurrences_v3(
	carac CHAR,
	chaine TEXT,
	debut INTEGER,
	fin INTEGER
)
RETURNS INTEGER AS $$
DECLARE
	nb_occurrences INTEGER := 0;
	i INTEGER := debut - 1;
BEGIN
	IF debut < 1 OR fin > LENGTH(chaine) OR debut > fin THEN
    	RAISE EXCEPTION 'Intervalle invalide';
	END IF;

	WHILE i < fin LOOP
    	i := i + 1;

    	IF SUBSTR(chaine, i, 1) = carac THEN
        	nb_occurrences := nb_occurrences + 1;
    	END IF;
	END LOOP;

	RETURN nb_occurrences;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getNbJoursParMois(date_input DATE)
RETURNS INTEGER AS $$
DECLARE
	nb_jours INTEGER;
BEGIN
	nb_jours := EXTRACT(DAY FROM (date_input + INTERVAL '1 MONTH' - INTERVAL '1 DAY'));
	RETURN nb_jours;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION dateSqlToDatefr(date_input DATE)
RETURNS TEXT AS $$
DECLARE
	date_fr TEXT;
BEGIN
	date_fr := TO_CHAR(date_input, 'DD/MM/YYYY');
    
	RETURN date_fr;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getNomJour(date_input DATE)
RETURNS TEXT AS $$
DECLARE
    nom_jour TEXT;
BEGIN
    nom_jour := TO_CHAR(date_input, 'Day');
    RETURN nom_jour;
END;
$$ LANGUAGE plpgsql;
