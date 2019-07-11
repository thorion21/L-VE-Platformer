local mydebug = {}

function mydebug.print_entity(e)
    print(e.id, '(ID)')
    for k, v in pairs(e.components) do
        print(k, v, '(Component)')
    end

    for _, tag in ipairs(e.tags) do
        print(tag, '(Tag)')
    end

    print('remove', e.remove, '(Property)')
    print('loaded', e.loaded, '(Property)')
end

function mydebug.tprint(t) for k, v in pairs(t) do print(k, v) end end
function mydebug.fprint(t)
    for k, v in pairs(t) do
        if (type(v) == 'table') then
            print(k, v)
            mydebug.fprint(v)
        else
            print(k, v)
        end
    end
end

return mydebug
