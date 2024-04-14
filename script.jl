time_mpi = @elapsed @eval using MPI
MPI.Init()
comm = MPI.COMM_WORLD
rank = MPI.Comm_rank(comm)
time_ode = @elapsed @eval using OrdinaryDiffEq
MPI.Barrier(comm)
open(joinpath(@__DIR__, "time_$rank"), "w") do io
    println(io, "MPI,", time_mpi)
    println(io, "OrdinaryDiffEq,", time_ode)
end
