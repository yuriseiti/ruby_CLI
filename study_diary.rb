require_relative "category"
require_relative "studyItem"

category_list = Array.new(2)
category_list[0] = Category.new(name: "Ruby")
category_list[1] = Category.new(name: "JavaScript")

study_list = []
finished_items = []

while true
    puts("===============================\n[1] Cadastrar um item para estudar
[2] Ver todos os itens cadastrados
[3] Buscar um item de estudo
[4] Listar por categoria
[5] Apagar um item
[8] Sair
Escolha um opção:")
    usr_input = gets.chomp
    
    case usr_input
    when "1"
        puts "\n"
        puts "Digite o título do seu item de estudo: "
        title = gets.chomp
        puts "\n"
        puts "[1] Ruby\n[2] Javascript"
        c_index = gets.chomp.to_i
        item = StudyItem.new(title: title, category: category_list[c_index-1])
        study_list.append(item)
        puts "\nItem adicionado."
    when "2"
        puts "\n"
        puts "Itens não concluídos: "
        study_list.each_with_index do |element, index|
            pp "#" + (index+1).to_s + " - " + element.title + " - " + element.category.name
        end
        if finished_items.size > 0
            puts "\n"
            puts "Itens concluídos: "
            finished_items.each_with_index do |element, index|
                pp "#" + (index+1).to_s + " - " + element.title + " - " + element.category.name
            end
        end
    when "3"
        puts "\n"
        puts "Digite uma palavra para procurar:"
        target_word = gets.chomp
        selected_items = study_list.select {|element| element.title.include? target_word}
        puts "\n"
        puts "Foram encontrados #{selected_items.size} resultados:"
        selected_items.each_with_index do |element, index|
            pp "#" + (index+1).to_s + " - " + element.title + " - " + element.category.name
        end
    when "4"
        puts "\n"
        puts "Digite qual categoria: \n[1] Ruby\n[2] Javascript"
        c_index = gets.chomp.to_i
        selected_items = study_list.select {|element| element.category == category_list[c_index-1]}
        selected_items.each_with_index do |element, index|
            pp "#" + (index+1).to_s + " - " + element.title + " - " + element.category.name
        end
    when "5"
        puts "\n"
        puts "Digite qual item deseja apagar:"
        study_list.each_with_index do |element, index|
            pp "#" + (index+1).to_s + " - " + element.title + " - " + element.category.name
        end
        i_index = gets.chomp.to_i
        study_list.delete_at(i_index-1)
        puts "Item #{i_index} deletado."
    when "7"
        puts "\n"
        puts "Digite qual item deseja marcar como concluído:"
        study_list.each_with_index do |element, index|
            pp "#" + (index+1).to_s + " - " + element.title + " - " + element.category.name
        end
        i_index = gets.chomp.to_i
        finished_items.append(study_list[i_index-1])
        study_list.delete_at(i_index-1)
        puts "Item #{i_index} marcado como concluído."
    when "8"
        exit
    end
    puts "\n\n"
end