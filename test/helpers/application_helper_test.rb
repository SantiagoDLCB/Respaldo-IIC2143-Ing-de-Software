require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "traducir_rol devuelve el nombre del rol correctamente" do
    assert_equal "Administrador", traducir_rol("admin_initiative")
    assert_equal "Miembro", traducir_rol("member")
    assert_equal "Administrador", traducir_rol("admin_event")
    assert_equal "Participante", traducir_rol("attendant")
  end

  test "traducir_rol capitaliza otros roles" do
    assert_equal "Moderator", traducir_rol("moderator")
    assert_equal "Usuario", traducir_rol("usuario")
    assert_equal "Visitante", traducir_rol("visitante")
  end

  test "traducir_rol devuelve el rol original si no hay traducción" do
    assert_equal "Superuser", traducir_rol("superuser")
    assert_equal "Owner", traducir_rol("owner")
  end

end
