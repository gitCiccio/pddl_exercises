(define (domain logistic-domain)
    (:requirements :typing)
    
    (:types truck city location package drone van)
    
    (:predicates 
        ; Static Map Facts
        (connected ?city1 - city ?city2 - city)
        (in-city ?location1 - location ?city1 - city)
        (is-hub ?location1 - location)
        (drone-allowed ?city1 - city)
        
        ; Dynamic Vehicle Locations
        (at-truck ?truck1 - truck ?location1 - location)
        (at-drone ?drone1 - drone ?location1 - location)
        (at-van ?van1 - van ?location1 - location)
        
        ; Dynamic Package States
        (at-package ?package1 - package ?location1 - location)
        (drone-delivery ?package1 - package ?drone1 - drone)
        (is-van-loaded ?van1 - van ?package1 - package)
        (drone-free ?drone1 - drone)
    )
    
    ; ----------------------------------------------------
    ; TRUCK ACTIONS (Strictly Hub-to-Hub)
    ; ----------------------------------------------------
    (:action drive-truck
        :parameters (?truck1 - truck ?city1 - city ?city2 - city ?location1 - location ?location2 - location)
        :precondition (and 
            (in-city ?location1 ?city1)
            (is-hub ?location1)           
            (in-city ?location2 ?city2)
            (is-hub ?location2)           
            (connected ?city1 ?city2)
            (at-truck ?truck1 ?location1)
        )
        :effect (and
            (at-truck ?truck1 ?location2)
            (not (at-truck ?truck1 ?location1))
        )
    )
    
    ; ----------------------------------------------------
    ; DRONE ACTIONS (Same City, 1 Package Capacity)
    ; ----------------------------------------------------
    (:action fly-drone
        :parameters (?drone1 - drone ?city1 - city ?location1 - location ?location2 - location)
        :precondition (and 
            (at-drone ?drone1 ?location1)
            (in-city ?location1 ?city1)
            (in-city ?location2 ?city1)
            (drone-allowed ?city1)
        )
        :effect (and
            (at-drone ?drone1 ?location2)
            (not (at-drone ?drone1 ?location1))
        )
    )

    (:action pick-drone
        :parameters (?drone1 - drone ?package1 - package ?location1 - location)
        :precondition (and 
            (at-drone ?drone1 ?location1)
            (at-package ?package1 ?location1)
            (drone-free ?drone1)
        )
        :effect (and
            (drone-delivery ?package1 ?drone1)
            (not (drone-free ?drone1))
            (not (at-package ?package1 ?location1))
        )
    )

    (:action drop-drone
        :parameters (?drone1 - drone ?package1 - package ?location1 - location)
        :precondition (and 
            (at-drone ?drone1 ?location1)
            (drone-delivery ?package1 ?drone1)
        )
        :effect (and
            (not (drone-delivery ?package1 ?drone1))
            (drone-free ?drone1)
            (at-package ?package1 ?location1)
        )
    )

    ; ----------------------------------------------------
    ; VAN ACTIONS (Same City, Unlimited Capacity)
    ; ----------------------------------------------------
    (:action drive-van
        :parameters (?van1 - van ?city1 - city ?location1 - location ?location2 - location)
        :precondition (and 
            (in-city ?location1 ?city1)
            (in-city ?location2 ?city1)
            (at-van ?van1 ?location1)
        )
        :effect (and
            (at-van ?van1 ?location2)
            (not (at-van ?van1 ?location1))
        )
    )

    (:action load-van
        :parameters (?van1 - van ?package1 - package ?location1 - location)
        :precondition (and
            (at-package ?package1 ?location1)
            (at-van ?van1 ?location1)
        )
        :effect(and
            (is-van-loaded ?van1 ?package1)
            (not (at-package ?package1 ?location1))
        )
    )
    
    (:action release-van
        :parameters (?van1 - van ?package1 - package ?location2 - location)
        :precondition (and
            (is-van-loaded ?van1 ?package1)
            (at-van ?van1 ?location2)
        )
        :effect(and
            (not (is-van-loaded ?van1 ?package1))
            (at-package ?package1 ?location2)
        )
    )
)