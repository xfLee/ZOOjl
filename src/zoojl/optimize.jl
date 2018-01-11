include("algos/asracos/asracos_optimization.jl")
include("algos/racos/racos_optimization.jl")

module optimize

importall asracos_optimization, objective, parameter, racos_optimization

export zoo_min

function zoo_min(obj::Objective, par::Parameter)
  if par.asynchronous == true
    algorithm = asyn_opt!
  else
    algorithm = opt!
  end
  optimizer = RacosOptimization()
  result = algorithm(optimizer, obj, par)
  return result
end

end