
return
Y
>=
(
    GROUND_PLANE
    -
    (
        (
            (
                (
                    (CITY_DISTANCE < Z) 
                    & 
                    (AVENUE_WIDTH < X)
                ) 
                % AVENUE_PERIOD
            
            )
            && 
            (
                (X / BUILDING_WIDTH) 
                ^ 
                (Z / BUILDING_DEPTH)
            )
          )
          *
          8
      )
      %
      (BUILDING_HEIGHT+1)
)
;


