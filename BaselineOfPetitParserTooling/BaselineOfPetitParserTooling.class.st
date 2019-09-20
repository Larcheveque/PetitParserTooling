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
		baseline: 'PharoCodeGenerator'
		with:
			[ spec repository: 'github://juliendelplanque/PharoCodeGenerator' ].
	spec
		for: #common
		do: [ "Packages"
			spec
				package: 'PetitParserTooling-Core'
				with: [ spec requires: #(PharoCodeGenerator) ].
			spec package: 'PetitParserTooling-PP2'.
			spec group: 'PetitParser2Boost' with: #('PetitParserTooling-PP2') ]
]
