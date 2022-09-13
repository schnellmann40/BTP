"! <p class="shorttext synchronized" lang="EN">Restful ABAP programming model %CID field</p>
class z_class_xxx definition
                  public
                  create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN"></p>
    types t_value type abp_behv_cid.

    "! <p class="shorttext synchronized" lang="EN">Instantiate random integer generator</p>
    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_value | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_value type z_class_xxx=>t_value.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter r_value | <p class="shorttext synchronized" lang="EN"></p>
    methods value
              returning
                value(r_value) type z_class_xxx=>t_value.

    "! <p class="shorttext synchronized" lang="EN">Create a CID from a system UUID or some fallback operation</p>
    "!
    "! @parameter r_unique_cid | <p class="shorttext synchronized" lang="EN">New (theoretically) unique CID</p>
    class-methods from_uuid_or_fallback
                    returning
                      value(r_unique_cid) type ref to z_class_xxx.

  protected section.

    "! <p class="shorttext synchronized" lang="EN"></p>
    data a_value type z_class_xxx=>t_value.

    "! <p class="shorttext synchronized" lang="EN"></p>
    class-data a_random_int_generator type ref to cl_abap_random_int8.

endclass.
class z_class_xxx implementation.

  method constructor.

    me->a_value = i_value.

  endmethod.
  method from_uuid_or_fallback.

    try.

      r_unique_cid = new #( conv #( cl_system_uuid=>create_uuid_x16_static( ) ) ).

    catch cx_uuid_error.

      r_unique_cid = new #( |cid_fallback&{ z_class_xxx=>a_random_int_generator->get_next( ) }| ).

    endtry.

  endmethod.
  method value.

    r_value = me->a_value.

  endmethod.
  method class_constructor.

    z_class_xxx=>a_random_int_generator = cl_abap_random_int8=>create( seed = cl_abap_context_info=>get_system_date( ) + cl_abap_context_info=>get_system_time( ) ).

  endmethod.

endclass.
