VAR health = 0.1
VAR energy = 0.2
VAR sanity = 0.3

-> demo
=== demo ===
~set_stat(health, 10)
~set_stat(energy, 10)
~set_stat(sanity, 10)
Your path is blocked by a boarded-up door.
+ [Charge straight into it.]
    ~alter_stat(health, -2)
+ [Break down the boards by hand.]
    ~alter_stat(energy, -1)
+ [Just go around.]
    ~alter_stat(sanity, 1)
-
Current stats:
~summarize(health)
~summarize(energy)
~summarize(sanity)
-> DONE


=== function alter_stat(ref x, amount) ===
    // ONLY USE INTEGER AMOUNTS!!
    ~x += amount
    ({amount > 0:+}{amount} {display_name(x)})

=== function display_name(x) ===
{x:
    - health: ~return "Health"
    - energy: ~return "Energy"
    - sanity: ~return "Sanity"
}

=== function summarize(x) ===
    {display_name(x)}: {get_stat(x)}

=== function set_stat(ref x, value) ===
    ~temp fractional = x - FLOOR(x)
    ~x = value + fractional

=== function get_stat(x) ===
    // You probably don't technically need this for most stat checks
    ~return FLOOR(x)