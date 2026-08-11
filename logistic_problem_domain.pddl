(define ((define (domain domainName)
    (:requirements :typing)
    
    (:types truck city location package)
    
    (:predicates 
        (connected ?city1 - city ?city2 - city)
        (in-city ?city1 - city ?truck - truck)
        (in-city-loc ?city1 - city ?location1 - location)
        (left-city ?truck1 - truck)
    )
    
    (:action drive
        :parameters (?truck1 - truck ?city1 - city ?location1 - location)
        :precondition (
            and (in-city-loc ?city1 ?location1)
                not ((in-city ?city1 ?truck))
            )
        :effect (and
            (fuu ?x)
            (not (fiu ?x ?x))
        )
    )
)))