.. _python_api:

Python API
----------

The following tutorial illustrates how to use the `DisFit` Python API.

Importing `DisFit`
^^^^^^^^^^^^^^^^^^^

Run this command to import `DisFit`::

    >>> import DisFit


Specifying an optimization problem
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All you need to specify an optimization problem is

* The **sbml file** of your ODE model (curently only sbml Level 2 Version 4 generated by Copasi has been tested).
* The **csv file** with your data. Columns are `t` for time in identical intervals and the names of the model species.

Optionally, you can also set

* **t_ratio**: ratio between experimental observation intervals and simulation time-discretization intervals. Default ``2``.
* **fold_change**: fold_change of the parameter fitting window with respect to the parameter values x_0 specified in the sbml file [x_0/fold_change, x_0*fold_change]. Default ``2``
* **n_starts**: number of multistarts. Default ``1``.

The problem is then specified as::

    >>> problem = DisFit.DisFitProblem(sbml_path, csv_path, t_ratio=2, fold_change=2, n_starts=1)

Once the problem is specified, `DisFit` has transformed the problem to a julia JuMP model. The code for this model can be accessed via::

    >>> code = problem.julia_code

or written to a file via::

    >>> problem.write_jl_file(path='path_to_jl_file.jl')

If you want to change the optimization problem in a way that is not yet supported by `DisFit`, you can manually modify the julia code and run the optimization in julia yourself.

Running the optimization
^^^^^^^^^^^^^^^^^^^^^^^^

The optimization can be run with::

    >>> problem.optimize()

Please note that this may take a while.

Accessing the results
^^^^^^^^^^^^^^^^^^^^^

The results can be accessed via::

    >>> results = problem.results

written to an excel file via::

    >>> problem.wirte_results(path='path_to_results.xlsx')

Time courses for the optimal solution together with the experimental datapoints can be plotted by::

    >>> problem.plot_results(path='path_to_plot.pdf', variables=[], size=(6, 5))

where the optional ``variables`` argument accepts a list of species that shall be plotted. The optional ``size`` argument specifies the size of the figure.