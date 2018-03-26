Miscelaneous functions
======================

These functions are not exported, and should be called by there fully qualified name:


.. jl:autofunction:: src/Chemfiles.jl version


Error handling
--------------

.. code-block:: julia

    Chemfiles.last_error()
    Chemfiles.set_warning_callback(my_callback)

.. jl:autofunction:: src/utils.jl last_error

.. jl:autofunction:: src/utils.jl clear_errors


Warnings
--------

.. jl:autofunction:: src/utils.jl set_warning_callback


Configuration files
-------------------

.. jl:autofunction:: src/utils.jl add_configuration
