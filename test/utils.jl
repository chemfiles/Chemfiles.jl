function silence_warning(message)
    nothing
end

function remove_chemfiles_warning(f::Function)
    Chemfiles.set_warning_callback(silence_warning)
    try
        f()
    finally
        Chemfiles.set_warning_callback(Chemfiles.__default_warning_callback)
    end
end
