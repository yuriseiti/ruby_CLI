require 'io/console'
require_relative "category"
require_relative "studyItem"

INSERT        = 1
VIEW_ALL      = 2
SEARCH        = 3
VIEW_CATEGORY = 4
DELETE_ITEM   = 5
MARK_AS_DONE  = 6
EXIT          = 7

category_list = Array.new(2)
category_list[0] = Category.new(name: "Ruby")
category_list[1] = Category.new(name: "JavaScript")

study_list = []
finished_items = []

def clear
    system 'clear'
end
  
def wait_keypress
    puts
    puts 'Pressione qualquer tecla para continuar'
    STDIN.getch
end
  
def wait_and_clear
    wait_keypress
    clear
end

def print_collection(collection)
    collection.each.with_index(1) do |element, index|
        puts "##{index} - #{element.title} - #{element.category.name}"
    end
end

def print_items(done, not_done)
    puts "\nItens não concluídos: " if !not_done.empty?
    print_collection(not_done)
    return if done.empty?

    puts "\nItens concluídos: "
    print_collection(done)
end

def insert_item(category_list)
    puts "\nDigite o título do seu item de estudo: "
    title = gets.chomp
    puts "\n[1] Ruby\n[2] Javascript"
    c_index = gets.to_i
    item = StudyItem.new(title: title, category: category_list[c_index-1])
    puts "\nItem adicionado."    
    return item
end


def search_word(collection, word)
    collection.select {|element| element.title.include? word}
end

def search_item(done, not_done)
    print "\nDigite uma palavra para procurar:"
    word = gets.chomp
    done_list = search_word(done, word)
    not_done_list = search_word(not_done, word)
    puts "\nForam encontrados #{done_list.size + not_done_list.size} resultados:"
    print_items(done_list, not_done_list)
end

def search_category(done, not_done, category_list)
    puts "\nDigite qual categoria: \n[1] Ruby\n[2] Javascript"
    c_index = gets.to_i
    done_list = done.select {|element| element.category == category_list[c_index-1]}
    not_done_list = not_done.select {|element| element.category == category_list[c_index-1]}
    print_items(done_list, not_done_list)
end

def delete_item(done, not_done)
    puts "Digite qual item deseja apagar: "
    print_collection(not_done + done)
    i_index = gets.to_i
    if i_index <= not_done.size
        not_done.delete_at(i_index - 1)
    elsif 
        done.delete_at(i_index - not_done.size - 1)
    end
    puts "Item #{i_index} deletado."    
end

def mark_item_as_done(done, not_done)
    puts "\n"
        puts "Digite qual item deseja marcar como concluído:"
        print_collection(not_done)
        i_index = gets.to_i
        done << not_done[i_index-1]
        not_done.delete_at(i_index-1)
        puts "Item #{i_index} marcado como concluído."
end

puts "Boas-vindas ao Diário de Estudos, seu companheiro para estudar!"
while true
    puts <<~MENU
    -----------------------------------------
    [#{INSERT}] Cadastrar um item para estudar
    [#{VIEW_ALL}] Ver todos os itens cadastrados
    [#{SEARCH}] Buscar um item de estudo
    [#{VIEW_CATEGORY}] Listar por categoria
    [#{DELETE_ITEM}] Apagar um item
    [#{MARK_AS_DONE}] Marcar um item como concluído
    [#{EXIT}] Sair
    -----------------------------------------
    MENU
    print "Escolha um opção: "
    usr_input = gets.to_i
    
    case usr_input
    when INSERT
        study_list << insert_item(category_list)
    when VIEW_ALL
        print_items(finished_items, study_list)
    when SEARCH
        search_item(finished_items, study_list)
    when VIEW_CATEGORY
        search_category(finished_items, study_list, category_list)
    when DELETE_ITEM
        delete_item(finished_items, study_list)
    when MARK_AS_DONE
        mark_item_as_done(finished_items, study_list)
    when EXIT
        puts "Obrigado por usar o Diário de Estudos"
        exit
    end
    wait_and_clear
end