class Unit < Struct.new(:id, :name, :initials, :rvalue)
  OFFENSE_DATA = [
    {id: 'agema-horseman',     name: 'Agema Horseman',     initials: 'AH', rvalue: 24277},
    {id: 'macedonian-cavalry', name: 'Macedonian Cavalry', initials: 'MC', rvalue: 19000},
    {id: 'spartan-promachos',  name: 'Spartan Promachos',  initials: 'SP', rvalue: 10610},
    {id: 'sarissophoros',      name: 'Sarissophoros',      initials: 'SS', rvalue: 7823},
    {id: 'spartan-hoplite',    name: 'Spartan Hoplite',    initials: 'SH', rvalue: 3520},
    {id: 'myrmidon',           name: 'Myrmidon',           initials: 'MY', rvalue: 2166},
    {id: 'hoplite',            name: 'Hoplite',            initials: 'HL', rvalue: 520},
    {id: 'swordsman',          name: 'Swordsman',          initials: 'SM', rvalue: 300}
  ]

  DEFENSE_DATA = [
    {id: 'mounted-peltast',  name: 'Mounted Peltast',  initials: 'MP', rvalue: 7500},
    {id: 'trojan-thorakite', name: 'Trojan Thorakite', initials: 'TT', rvalue: 5300},
    {id: 'thureophorus',     name: 'Thureophorus',     initials: 'TH', rvalue: 5000},
    {id: 'creatan-archer',   name: 'Cretan Archer',    initials: 'CA', rvalue: 1900},
    {id: 'peltast',          name: 'Peltast',          initials: 'PL', rvalue: 1760},
    {id: 'psilos',           name: 'Psilos',           initials: 'PS', rvalue: 192},
    {id: 'javelineer',       name: 'Javelineer',       initials: 'JV', rvalue: 120}
  ]

  UNITS = (OFFENSE_DATA + DEFENSE_DATA).each_with_object({}) do |unit,map|
    map[unit[:id]] = Unit.new(*unit.values)
  end

  def self.find(id)
    raise "No unit found for ID: #{id}" unless UNITS.has_key? id
    UNITS[id]
  end

  def self.all
    UNITS.values
  end

  def self.offense
    all.first(8)
  end

  def self.defense
    all.last(7)
  end

  def self.ids
    UNITS.keys
  end
end
