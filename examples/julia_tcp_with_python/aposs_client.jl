using ZOOjl
using PyPlot

dim_size = 60
dim_regs = [[0, 1] for i = 1:dim_size]
dim_tys = [false for i = 1:dim_size]
mydim = Dimension(dim_size, dim_regs, dim_tys)
obj = Objective(mydim)

par = Parameter(algorithm="aposs", budget=10000, computer_num=2, control_server_ip="192.168.1.105",
    control_server_port=[20001, 20002, 20003], working_directory="sparse_mse.py", func="target_func")

sol = zoo_min(obj, par)

sol_print(sol)
history = get_history_bestsofar(obj)
plt[:plot](history)
plt[:savefig]("figure.pdf")