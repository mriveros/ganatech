module DisciplinasHelper

  def link_to_editar_disciplina(disciplina)
    render partial: 'link_to_editar_disciplina', locals: { disciplina: disciplina }
  end

end
