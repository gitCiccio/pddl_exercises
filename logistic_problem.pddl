(define (problem logistic-ext3-test)
    (:domain logistic-domain) 

    (:objects 
        rome milan - city
        rome-hub rome-postoffice milan-hub milan-postoffice - location
        truck1 - truck
        drone1 - drone
        van-rome van-milan - van
        pkg1 pkg2 pkg3 - package
    )

    (:init 
        ; 1. Define the Geography
        (in-city rome-hub rome)
        (in-city rome-postoffice rome)
        (in-city milan-hub milan)
        (in-city milan-postoffice milan)
        
        ; Define Hubs 
        (is-hub rome-hub)
        (is-hub milan-hub)
        
        ; 2. Define the Connections
        (connected rome milan)
        (connected milan rome)
        (drone-allowed milan)
        (drone-allowed rome)

        ; 3. Define Starting Positions
        (at-truck truck1 rome-hub)
        
        (at-drone drone1 rome-hub)
        (drone-free drone1)
        
        (at-van van-rome rome-postoffice)
        (at-van van-milan milan-hub)
        
        (at-package pkg1 rome-hub)
        (at-package pkg2 rome-postoffice)
        (at-package pkg3 milan-postoffice)
    )

    (:goal (and 
        (at-package pkg1 milan-hub)
        (at-package pkg2 milan-postoffice)
        (at-package pkg3 rome-postoffice)
    ))
)