using Plots

function mb((x, y), escape = 100.0, max = 255)
  iter = 0
  ζ = 0

  while abs(ζ) < escape && iter < max
    ζ = ζ^2 + x + y*im
    iter += 1
  end

  return iter
end

function newton(f, ϵ = 1e-10)
  function fp(x)
    (f(x + ϵ) - f(x))/ϵ
  end

  function((x, y), max = 100)
    iter = 0
    ζ = x + y*im

    while abs(f(ζ)) > ϵ && iter < max
      ζ = ζ - f(ζ)/fp(ζ)
      iter += 1
    end

    return iter
  end
end

function field(from, to, step)
  axis = collect(from:step:to)

  A = axis' .* ones(length(axis))
  B = ones(length(axis))' .* axis

  return collect(zip(A, B))
end

heatmap(newton(z -> tanh(z)^2).(field(-5, 5, 0.01)))
