#!/bin/csh
set verbose
set echo

set init = 21               #initial .gro
set np = 12                 #number of cores to use with mpirun
set folder = `pwd`          #directory where .gro, .mdp, etc.

set int    = 700        #first temperature
set intmin = 150

while ( ${int} >= ${intmin} )
    @ pint = ${int} + 25
    if ( ${int} == 700 ) set pstep = ${init}

    cd ${folder}
    mkdir ${int}
    cp topol.top ${int}/ && cp ${folder}/inputs/npt${int}K.mdp ${folder}/${int}/npt${int}K.mdp  
    if ( ${int} == 700 ) cp ${init}.gro ${int}K/

    gmx_mpi grompp -f npt${int}.mdp -o ${int}.tpr -c ${pint}.gro -r ${init}gro -p topol.top -n index.ndx
    mpirun -np ${np} gmx_mpi mdrun -v -deffnm ${int}
    @ cnt -= 25
end







