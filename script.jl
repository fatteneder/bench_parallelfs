time_mpi = @elapsed @eval using MPI
MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)

if length(ARGS) < 1
    if rank == 0
        println("""usage: script.jl "outputdir" """)
    end
    MPI.Barrier(comm)
    exit(-1)
end

MPI.Barrier(comm)
time_ode = @elapsed @eval using OrdinaryDiffEq
MPI.Barrier(comm)

outputdir = ARGS[1]
open(joinpath(outputdir, "time_$rank"), "w") do io
    println(io, "MPI,", time_mpi)
    println(io, "OrdinaryDiffEq,", time_ode)
end
