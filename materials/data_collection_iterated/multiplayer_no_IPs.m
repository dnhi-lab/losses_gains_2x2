function [ip_addr, con, participant] = multiplayer(study, multi_num, participant)
if multi_num == 1
    pc = input('Computer Nr(room 201:1-6)');
    % Set the IP adresses for the PCs, dependent on who is playing against whom in this round. The host has an IP of '0' and
    % the client has an IP of the PC it's connecting to (i.e., 'x.x.x.x' if connecting to the first PC).
    if study.combosOrder == 1 % study.pairing = [1 2 3 4 5 6] i.e., [1-2 3-4 5-6]
        switch pc
            case 1
                ip_addr = '';
            case 2
                ip_addr = '';
            case 3
                ip_addr = '';
            case 4
                ip_addr = '';
            case 5
                ip_addr = '';
            case 6
                ip_addr = '';
        end
    elseif study.combosOrder == 2 % study.pairing == [1 3 2 5 4 6] i.e., [1-3 2-5 4-6]
        switch pc
            case 1
                ip_addr = '';
            case 2
                ip_addr = '';
            case 3
                ip_addr = '';
            case 4
                ip_addr = '';
            case 5
                ip_addr = '';
            case 6
                ip_addr = '';
        end
    elseif study.combosOrder == 3 % study.pairing == [1 4 2 6 3 5] i.e., [1-4 2-6 3-5]
        switch pc
            case 1
                ip_addr = '';
            case 2
                ip_addr = '';
            case 3
                ip_addr = '';
            case 4
                ip_addr = '';
            case 5
                ip_addr = '';
            case 6
                ip_addr = '';
        end
    elseif study.combosOrder == 4 % study.pairing == [1 5 2 4 3 6] i.e., [1-5 2-4 3-6]
        switch pc
            case 1
                ip_addr = '';
            case 2
                ip_addr = '';
            case 3
                ip_addr = '';
            case 4
                ip_addr = '';
            case 5
                ip_addr = '';
            case 6
                ip_addr = '';
        end
    elseif study.combosOrder == 5 % study.pairing == [1 6 2 3 4 5] i.e., [1-6 2-3 4-5]
        switch pc
            case 1
                ip_addr = '';
            case 2
                ip_addr = '';
            case 3
                ip_addr = '';
            case 4
                ip_addr = '';
            case 5
                ip_addr = '';
            case 6
                ip_addr = '';
        end
    end
    if (ip_addr == '0') % server
        sockcon = pnet('tcpsocket',5126);
        con=pnet(sockcon,'tcplisten');
    else % client
        con = pnet('tcpconnect',ip_addr,5126);
    end
else
    ip_addr = NaN;
    con = NaN;
end

if multi_num == 1
    if pc == 1
        if study.combosOrder == 1
            participant.other = 2;
        elseif study.combosOrder == 2
            participant.other = 3;
        elseif study.combosOrder == 3
            participant.other = 4;
        elseif study.combosOrder == 4
            participant.other = 5;
        elseif study.combosOrder == 5
            participant.other = 6;
        end
    end  

    if pc == 2
        if study.combosOrder == 1
            participant.other = 1;
        elseif study.combosOrder == 2
            participant.other = 5;
        elseif study.combosOrder == 3
            participant.other = 6;
        elseif study.combosOrder == 4
            participant.other = 4;
        elseif study.combosOrder == 5
            participant.other = 3;
        end
    end    

    if pc == 3
        if study.combosOrder == 1
            participant.other = 4;
        elseif study.combosOrder == 2
            participant.other = 1;
        elseif study.combosOrder == 3
            participant.other = 5;
        elseif study.combosOrder == 4
            participant.other = 6;
        elseif study.combosOrder == 5
            participant.other = 2;
        end
    end    

    if pc == 4
        if study.combosOrder == 1
            participant.other = 3;
        elseif study.combosOrder == 2
            participant.other = 6;
        elseif study.combosOrder == 3
            participant.other = 1;
        elseif study.combosOrder == 4
            participant.other = 2;
        elseif study.combosOrder == 5
            participant.other = 5;
        end
    end 

    if pc == 5
        if study.combosOrder == 1
            participant.other = 6;
        elseif study.combosOrder == 2
            participant.other = 2;
        elseif study.combosOrder == 3
            participant.other = 3;
        elseif study.combosOrder == 4
            participant.other = 1;
        elseif study.combosOrder == 5
            participant.other = 4;
        end
    end

    if pc == 6
        if study.combosOrder == 1
            participant.other = 5;
        elseif study.combosOrder == 2
            participant.other = 4;
        elseif study.combosOrder == 3
            participant.other = 2;
        elseif study.combosOrder == 4
            participant.other = 3;
        elseif study.combosOrder == 5
            participant.other = 1;
        end
    end
elseif multi_num == 0
    participant.other = 0;
end

end