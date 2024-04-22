from experta import *

class PCDiagnosis(KnowledgeEngine):
    diagnoses = []
    initialFacts = []


    @DefFacts()
    def initial(self):
        for fact in self.initialFacts:
            yield Fact(symptom = fact)
        # yield Fact(symptom='PC_does_not_boot')
        # yield Fact(symptom='Power_indicator_on_but_no_display')
        # yield Fact(symptom='Unusual_noise_from_PC')
        # yield Fact(symptom='System_overheating')
        # yield Fact(symptom='Intermittent_freezing')
        # yield Fact(symptom='System_crashes_on_startup')
        # yield Fact(symptom='Slow_system_performance')
        # yield Fact(symptom='Hardware_failure_warning')
        # yield Fact(symptom='Unable_to_access_data')
        # yield Fact(symptom='Strange_error_messages')
        # yield Fact(symptom='Peripheral_device_failure')
        # yield Fact(symptom='Blue_screen_of_death')
        # yield Fact(symptom='Network_connection_issues')
        # yield Fact(symptom='Battery_not_charging')
        # yield Fact(symptom='Missing_files_or_icons')
        # yield Fact(symptom='Application_errors')
        # yield Fact(symptom='Random_restarts')
        # yield Fact(symptom='Loud_fan_noise')
        # yield Fact(symptom='Computer_shuts_down_abruptly')
        # yield Fact(symptom='USB_device_not_recognized')





    @Rule(Fact(symptom='PC_does_not_boot'))
    def pc_does_not_boot(self):
        if not check_if_value_in_dict(self.diagnoses,'PC does not boot'):
            diagnoses = {
                'diagnosis': 'PC does not boot',
                'Solution': 'You Should check the power supply, the power indicator and the system crashes on startup.'
            }
            self.diagnoses.append(diagnoses)


        ## 
    @Rule(AND(
        Fact(symptom='PC_does_not_boot'),
        OR(
            Fact(symptom='Power_indicator_on_but_no_display'),
            Fact(symptom='System_crashes_on_startup')
        ),
        NOT(Fact(symptom='Peripheral_device_failure'))
    ))
    def boot_issue(self):
        if not check_if_value_in_dict(self.diagnoses,'Boot issue'):
            diagnnose = {
                'diagnosis': 'Boot issue',
                'Solution': '''This issue is related to the computer not booting. It could be as a result of the power indicator being on but no display or the system crashes on startup. ,  you should
                check the power supply, the power indicator and the system crashes on startup.
                '''
            }
            self.diagnoses.append(diagnnose)

    @Rule(AND(
        Fact(symptom='Slow_system_performance'),
        OR(
            Fact(symptom='Application_errors'),
            Fact(symptom='Random_restarts')
        )
    ))
    def performance_issue(self):
        if not check_if_value_in_dict(self.diagnoses,'Performance issue'):
            diagnoses = {
                'diagnosis': 'Performance issue',
                'Solution': '''You should check the system overheating, the intermittent freezing and the application errors.'''
                
            }
            self.diagnoses.append(diagnoses)

    @Rule(AND(
        Fact(symptom='Unusual_noise_from_PC'),
        OR(
            Fact(symptom='Loud_fan_noise'),
            Fact(symptom='Computer_shuts_down_abruptly')
        )
    ))
    def hardware_issue(self):
        if not check_if_value_in_dict(self.diagnoses,'Hardware issue'):
            diagnoses = {
                'diagnosis': 'Hardware issue',
                'Solution': ''' This is typically a hardware issue. You should check the system overheating, the intermittent freezing and the application errors.'''
            }
            self.diagnoses.append(diagnoses)


    @Rule(AND(
        Fact(symptom='System_overheating'),
        OR(
            Fact(symptom='Intermittent_freezing'),
            Fact(symptom='Slow_system_performance')
        )
    ))
    def cooling_issue(self):
        if   not check_if_value_in_dict(self.diagnoses,'Cooling issue'):
            diagnoses = {
                'diagnosis': 'Cooling issue',
                'Solution': '''This issue is related to the system overheating, the intermittent freezing and the slow system performance.'''
            }
            self.diagnoses.append(diagnoses)

    @Rule(AND(
        Fact(symptom='Peripheral_device_failure'),
        OR(
            Fact(symptom='USB_device_not_recognized'),
            Fact(symptom='Network_connection_issues')
        )
    ))
    def peripheral_issue(self):
        if not check_if_value_in_dict(self.diagnoses,'Peripheral issue'):
            diagnoses = {
                'diagnosis': 'Peripheral issue',
                'Solution': '''This issue is related to the peripheral device failure, the USB device not recognized and the network connection issues.'''
            }
            self.diagnoses.append(diagnoses)

    @Rule(AND(
        Fact(symptom='Strange_error_messages'),
        OR(
            Fact(symptom='Blue_screen_of_death'),
            Fact(symptom='Missing_files_or_icons')
        )
    ))
    def software_issue(self):
        if  not check_if_value_in_dict(self.diagnoses,'Software issue'):
            diagnoses = {
                'diagnosis': 'Software issue',
                'Solution': '''This issue is related to the strange error messages, the blue screen of death and the missing files or icons.'''
            }
            self.diagnoses.append(diagnoses)

    @Rule(AND(
        Fact(symptom='Unable_to_access_data'),
        Fact(symptom='Missing_files_or_icons'),
        NOT(Fact(symptom='Strange_error_messages'))
    ))
    def data_access_issue(self):
        
        if not check_if_value_in_dict(
            self.diagnoses,
            'Data access issue'
        ):

            diagnoses = {
                'diagnosis': 'Data access issue',
                'Solution': '''This issue is related to the unable to access data, the missing files or icons and the strange error messages.'''
            }
            self.diagnoses.append(diagnoses)


    @Rule(AND(
        Fact(symptom='System_overheating'),
        Fact(symptom='Intermittent_freezing'),
        Fact(symptom='Application_errors')
    ))
    def overheating_issue(self):
        if  not check_if_value_in_dict(self.diagnoses,'Overheating issue'):
            diagnoses = {
                'diagnosis': 'Overheating issue',
                'Solution': '''This issue is related to the system overheating, the intermittent freezing and the application errors.'''
            }

    @Rule(AND(
        Fact(symptom='Peripheral_device_failure'),
        Fact(symptom='USB_device_not_recognized'),
        NOT(Fact(symptom='Network_connection_issues'))
    ))
    def usb_issue(self):
        if not check_if_value_in_dict(self.diagnoses,'USB device issue'):
            diagnoses = {
                'diagnosis': 'USB device issue',
                'Solution': '''This issue is related to the peripheral device failure, the USB device not recognized and the network connection issues.'''
            }
            self.diagnoses.append(diagnoses)   

    @Rule(AND(
        Fact(symptom='PC_does_not_boot'),
        Fact(symptom='Strange_error_messages'),
        Fact(symptom='Peripheral_device_failure')
    ))
    def boot_failure(self):
        if not check_if_value_in_dict(
            self.diagnoses,
            'Boot failure'
        ):


            diagnoses = {
                'diagnosis': 'Boot failure',
                'Solution': '''This issue is related to the PC does not boot, the strange error messages and the peripheral device failure.'''
            }
            self.diagnoses.append(diagnoses)

    @Rule(AND(
        Fact(symptom='System_overheating'),
        Fact(symptom='Intermittent_freezing'),
        Fact(symptom='Slow_system_performance'),
        Fact(symptom='Application_errors')
    ))
    def critical_issue(self):
        if not check_if_value_in_dict(self.diagnoses,
                                        'Critical issue'
                                ):
            diagnoses = {
                'diagnosis': 'Critical issue',
                'Solution': ''' this is typically a critical issue. You should check the system overheating, the intermittent freezing, the slow system performance and the application errors.'''
                
            }
            self.diagnoses.append(diagnoses)

    @Rule(AND(
        Fact(symptom='Peripheral_device_failure'),
        Fact(symptom='Random_restarts')
    ))
    def peripheral_restart_issue(self):
        if not check_if_value_in_dict(self.diagnoses,
                                        'Peripheral restart issue'
                                ): 
            diagnoses = {
                'diagnosis': 'Peripheral restart issue',
                'Solution': '''This issue is related to the peripheral device failure and the random restarts. , to fix this you need to check the peripheral device failure and the random restarts.'''
            }
            self.diagnoses.append(diagnoses)

    @Rule(AND(
        Fact(symptom='PC_does_not_boot'),
        Fact(symptom='Slow_system_performance'),
        NOT(Fact(symptom='System_crashes_on_startup'))
    ))
    def boot_performance_issue(self):
        if not check_if_value_in_dict(self.diagnoses,
                                        'Boot performance issue'
                                ):
            diagnoses = {
                'diagnosis': 'Boot performance issue',
                'Solution': '''This issue is related to the PC does not boot, the slow system performance and the system crashes on startup.'''
            }
            self.diagnoses.append(diagnoses)

    @Rule()
    def default_diagnosis(self):
        if not self.diagnoses:
                diagnoses = {
                    'diagnosis': 'No diagnosis found',
                    'Solution': 'No solution found'
                }
                self.diagnoses.append(diagnoses)

    @Rule(Fact(symptom=MATCH.symptom), salience=-1)
    def display_diagnoses(self, symptom):
        if self.diagnoses:
            print("Diagnoses for symptom", symptom)
            for diagnosis in self.diagnoses:
                print("- ", diagnosis)
        else:
            print("No diagnoses for symptom", symptom)


def check_if_value_in_dict(dict, value):
    for item in dict: 
        if item['diagnosis'] == value:
            return True