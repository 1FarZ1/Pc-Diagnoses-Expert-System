
from expert_system import PCDiagnosis
from experta import Fact

def main():
    engine = PCDiagnosis()
    symptoms = [
            'PC_does_not_boot',
            # 'Power_indicator_on_but_no_display',
            # 'Unusual_noise_from_PC',
            # 'System_overheating',
            # 'Intermittent_freezing',
            # 'System_crashes_on_startup',
            # 'Slow_system_performance',
            # 'Hardware_failure_warning',
            # 'Unable_to_access_data',
            # 'Strange_error_messages',
            # 'Peripheral_device_failure',
            # 'Blue_screen_of_death',
            # 'Network_connection_issues',
            # 'Battery_not_charging',
            # 'Missing_files_or_icons',
            # 'Application_errors',
            # 'Random_restarts',
            # 'Loud_fan_noise',
            # 'Computer_shuts_down_abruptly',
            # 'USB_device_not_recognized'
        ]

    engine.initialFacts = symptoms     
    engine.reset()
    engine.run()


    print(engine.agenda)
    print(engine.facts)
    print(engine.diagnoses)


if __name__ == '__main__':
    main()

    # <f-1>: Fact(<frozendict {'symptom': 'PC_does_not_boot'}>)