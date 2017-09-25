class Error < RuntimeError
end

class PetNotFound < Error
end

class NotEnoughMoney < Error
end


def pet_shop_name(pet_shop)
  pet_shop[:name]
end

def total_cash(pet_shop)
  pet_shop[:admin][:total_cash]
end

def add_or_remove_cash!(pet_shop, amount)
  pet_shop[:admin][:total_cash] += amount
end

def pets_sold(pet_shop)
  pet_shop[:admin][:pets_sold]
end

def increase_pets_sold!(pet_shop, amount)
  pet_shop[:admin][:pets_sold] += amount
end

def stock_count(pet_shop)
  pet_shop[:pets].length
end

def pets_by_breed(pet_shop, breed)
  pet_shop[:pets].each_with_object(pets = []) { |pet|
    pets << pet if pet[:breed] == breed
  }
end

def find_pet_by_name(pet_shop, name)
  pet_shop[:pets].each { |pet|
    return pet if pet[:name] == name
  }
  nil
end

def remove_pet_by_name!(pet_shop, name)
  pet_shop[:pets].reject! { |pet|
    pet[:name] == name
  }
end

def add_pet_to_stock!(pet_shop, new_pet)
  pet_shop[:pets] << new_pet
end

def customer_pet_count(customer)
  customer[:pets].length
end

def add_pet_to_customer!(customer, new_pet)
  customer[:pets] << new_pet
end

def remove_cash_from_customer!(customer, amount)
  customer[:cash] -= amount
end

def customer_can_afford_pet?(customer, pet)
  customer[:cash] >= pet[:price]
end

def sell_pet_to_customer!(pet_shop, pet, customer)
  raise PetNotFound unless pet
  raise NotEnoughMoney unless customer_can_afford_pet?(customer, pet)

  remove_pet_by_name!(pet_shop, pet[:name])

  remove_cash_from_customer!(customer, pet[:price])
  add_or_remove_cash!(pet_shop, pet[:price])

  add_pet_to_customer!(customer, pet)

  increase_pets_sold!(pet_shop, 1)
end
