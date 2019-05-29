"
baseline
"
Class {
	#name : #BaselineOfPetitParserTooling,
	#superclass : #BaselineOf,
	#category : #BaselineOfPetitParserTooling
}

{ #category : #baselines }
BaselineOfPetitParserTooling >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Packages"
			spec package: 'PetitParserTooling-Core'.
			spec package: 'PetitParserTooling-PP2'.
			spec group: 'PetitParser2Boost' with: #('PetitParserTooling-PP2') ]
]
