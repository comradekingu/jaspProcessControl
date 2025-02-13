
// Copyright (C) 2013-2018 University of Amsterdam
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

import QtQuick 									2.8
import QtQuick.Layouts 							1.3
import JASP.Controls 							1.0
import JASP.Widgets 							1.0

Form
{
	columns:									1

	DropDown
	{
		id: 									gaugeRRdataFormat
		name: 									"testRetestDataFormat"
		label: 									qsTr("Data format")
		indexDefaultValue:						0
		values: [
			{ label: qsTr("Single column"), value: "testRetestLongFormat"},
			{ label: qsTr("Across rows"), value: "testRetestWideFormat"}
		]
		onValueChanged:
		{
			measurements.itemDoubleClicked(0)
			measurementsLong.itemDoubleClicked(0)
		}
	}

	VariablesForm
	{
		id:										variablesForm

		AvailableVariablesList
		{
			name:								"variablesForm"
		}

		AssignedVariablesList
		{
			name:								"operators"
			title:								qsTr("Operator / Repetition")
			singleVariable:						true
			allowedColumns:						["nominal", "nominalText", "ordinal"]
			visible:							gaugeRRdataFormat.currentValue == "testRetestLongFormat"
		}

		AssignedVariablesList
		{
			name:								"parts"
			title:								qsTr("Parts")
			singleVariable:						true
			allowedColumns:						["nominal", "nominalText", "ordinal", "scale"]
		}

		AssignedVariablesList
		{
			id:									measurementsLong
			name:								"measurementsLong"
			title:								qsTr("Measurements")
			singleVariable:						true
			visible:							gaugeRRdataFormat.currentValue == "testRetestLongFormat"
			allowedColumns:						["scale"]
		}

		AssignedVariablesList
		{
			id:									measurements
			name:								"measurements"
			title:								qsTr("Measurements")
			visible:							gaugeRRdataFormat.currentValue == "testRetestWideFormat"
			allowedColumns:						["scale"]
		}
	}

	Section
	{
		title: 									qsTr("Range Method Options")

		Group
		{
			title: 								qsTr("Analysis Options")

			CheckBox
			{
				name:							"EnableRangePSD"
				childrenOnSameRow:				true

				DoubleField
				{
					name:						"rangePSD"
					label:						qsTr("Process Std. Deviation")
				}
			}

			CheckBox
			{
				name:							"EnableRangeTolerance"
				childrenOnSameRow: 				true

				DoubleField
				{
					name:						"rangeTolerance"
					label:						qsTr("Tolerance")
				}
			}

			CheckBox
			{
				name: 							"rangeRr"
				label: 							qsTr("r&R table")
				checked: 						true
			}
		}

		Group
		{
			title: 								qsTr("Plots")

			CheckBox
			{
				name: 							"rangeScatterPlotOperatorParts"
				label:							qsTr("Run chart of parts")
			}

			CheckBox
			{
				name:							"rangeScatterPlotOperators"
				label:							qsTr("Scatter plot")
				checked:						true

				CheckBox
				{
					name:						"rangeScatterPlotFitLine"
					label:						qsTr("Regression line")
					checked:					true
				}

				CheckBox
				{
					name:						"jitter"
					label:						qsTr("Jitter")
				}
			}

			CheckBox
			{
				name: 							"rangeRchart"
				label: 							qsTr("Range chart")
			}

			CheckBox
			{
				name: 							"trafficPlot"
				label: 							qsTr("Traffic light graph")
			}
		}
	}
}
