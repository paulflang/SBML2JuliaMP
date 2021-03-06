.. _cli:

Command line interface
----------------------

To excecute a parameter fitting problem from the command line interface (CLI) you need to specify your optimization problem in the `PEtab format <https://petab.readthedocs.io/en/stable/documentation_data_format.html>`_, which is built around SBML and TSV files. If you also want to customise upper and lower boundaries for model species, you can provide an additional species table (see `species_Vinod_FEBS2015.tsv <https://github.com/paulflang/sbml2julia/blob/main/examples/Vinod_FEBS2015/species_Vinod_FEBS2015.tsv>`_ as an example).

The `sbml2julia` CLI allows you to specify the following optimization options:

* **-t**, **--t_steps**: number of time-discretization steps. Default ``None``.
* **-n**, **--n_starts**: number of multistarts. Default ``1``.
* **-i**, **--infer_ic_from_sbml**: infer initial conditions which are not specified in the PEtab condition table from SBML. Default ``False``.
* **-o**, **--optimizer_options**: `optimization solver options <https://jump.dev/JuMP.jl/dev/solvers/#JuMP.set_optimizer_attributes>`_. Default ``{}``.
* **-c**, **--custom_code_dict**: dict with replaced code as keys and replacement code as values. Default ``{}``.
* **-d**, **--out_dir**: output directory for julia_code, results and plot. Default ``'./results/'``.
* **-p**, **--plot_obs**: list of observables to be plotted. Default all, i.e. ``[]``.

The problem is then specified and solved via::

    user@bash:/$ sbml2julia optimize 'my_petab_promlem.yaml' -t 100 -n 1 -i 'False' -o {} -c {} -d './results' -p '[]'

The results can be found in the output directory given to the ``-d`` argument.

Choosing an HSL linear solver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Optionally, the ``optimizer_options`` attribute can be used to specify the linear solver used within `Ipopt`. For example::

    user@bash:/$ sbml2julia optimize 'my_petab_promlem.yaml' -t 100 -n 1 -i 'False' -o '{linear_solver: ma57}' -c {} -d './results' -p '[]'
