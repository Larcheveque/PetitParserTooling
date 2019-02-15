"
When a choice (/) is defined in a parser rule, it must be resolved to know how to name the ast node.

example: <reify: #( parametrizedType / basicType / customType ) into: #type>
"
Class {
	#name : #PPTChoiceReificationNotDefined,
	#superclass : #Error,
	#instVars : [
		'rulesCombination'
	],
	#category : #'PetitParserTooling-Core'
}

{ #category : #accessing }
PPTChoiceReificationNotDefined >> messageText [
	^ 'You should define a pragma in your rule to express how the multiple choice (/) should be named in a unique name: '
		, self rulesCombination asString
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> rulesCombination [
	^ rulesCombination
]

{ #category : #accessing }
PPTChoiceReificationNotDefined >> rulesCombination: anObject [
	rulesCombination := anObject
]
