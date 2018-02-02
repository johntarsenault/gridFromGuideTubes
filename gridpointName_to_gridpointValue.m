function [positionValAP positionValLM] = gridpointName_to_gridpointValue(positionNameAP,positionNameLM)

        switch positionNameAP
            case '7A'
                positionValAP = 7;
            case '6A'
                positionValAP = 6;
            case '5A'
                positionValAP = 5;
            case '4A'
                positionValAP = 4;
            case '3A'
                positionValAP = 3;
            case '2A'
                positionValAP = 2;
            case '1A'
                positionValAP = 1;
            case 'C'
                positionValAP = 0;
            case '1P'
                positionValAP = -1;
            case '2P'
                positionValAP = -2;
            case '3P'
                positionValAP = -3;
            case '4P'
                positionValAP = -4;
            case '5P'
                positionValAP = -5;
            case '6P'
                positionValAP = -6;
            case '7P'
                positionValAP = -7;
            otherwise
                error(sprintf('this AP position: %s is not in the standard grid',positionNameAP))
        end
        
            
                switch positionNameLM
            case '7L'
                positionValLM = 7;
            case '6L'
                positionValLM = 6;
            case '5L'
                positionValLM = 5;
            case '4L'
                positionValLM = 4;
            case '3L'
                positionValLM = 3;
            case '2L'
                positionValLM = 2;
            case '1L'
                positionValLM = 1;
            case 'C'
                positionValLM = 0;
            case '1M'
                positionValLM = -1;
            case '2M'
                positionValLM = -2;
            case '3M'
                positionValLM = -3;
            case '4M'
                positionValLM = -4;
            case '5M'
                positionValLM = -5;
            case '6M'
                positionValLM = -6;
            case '7M'
                positionValLM = -7;
            otherwise
                error(sprintf('this LM position: %s is not in the standard grid',positionNameAP))
            end