data {
  int<lower=0> N;               // number of data points
  int<lower=1> J;               // number of groups
  int<lower=1, upper=J> group[N]; // group indicator
  vector[N] x;                  // predictor
  vector[N] y;                  // outcome
}

transformed data {
  real x_mean = mean(x);        // center x for numerical stability
}

parameters {
  real alpha;                   // global intercept
  real beta;                    // global slope
  real<lower=0> sigma_y;        // observation noise
  vector[J] group_effect;       // group-level effect
  real<lower=0> sigma_group;    // group-level std dev
}

transformed parameters {
  vector[N] mu;
  for (n in 1:N) {
    mu[n] = alpha + beta * (x[n] - x_mean) + group_effect[group[n]];
  }
}

model {
  // Priors
  alpha ~ normal(0, 5);
  beta ~ normal(0, 5);
  sigma_y ~ exponential(1);
  group_effect ~ normal(0, sigma_group);
  sigma_group ~ exponential(1);

  // Likelihood
  y ~ normal(mu, sigma_y);
}

generated quantities {
  vector[N] y_rep;
  for (n in 1:N) {
    y_rep[n] = normal_rng(mu[n], sigma_y); // posterior predictive
  }
}

