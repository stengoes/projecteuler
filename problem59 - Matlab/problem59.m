clear all;
clc;

chiper = load('p059_cipher.txt', '-ascii');
chiper_text = char(chiper);

keywords = {'hello', 'house', 'find', 'take', 'would', 'good', 'yes', 'information', 'people', 'world', 'euler', 'great'};    
found = 0;
for key1 = 97:122
    if(found)
        break;
    end;
    for key2 = 97:122
        if(found)
            break;
        end;
        for key3 = 97:122
            if(found)
                break;
            end;
            
            %create key
            key = [key1 key2 key3];

            %decrypt
            decrypt = zeros(1, length(chiper));
            for n=1:3:length(chiper)-3
                decrypt(n:(n+2)) = bitxor(chiper(n:(n+2)), key); 
            end;
            
            %last part
            temp = bitxor([chiper(end) 0 0], key);
            decrypt(end) = temp(1);
            
            %check if decrypt succeeded (check for keywords)
            decrypt_text = char(decrypt);
            counter = 0;
            for i = 1:length(keywords)
                foundword = strfind(decrypt_text, char(keywords(i)));
                if(~isempty(foundword))
                    counter = counter + 1;
                end;
                if(counter > 1)
                    found = 1;
                    break;
                end;                    
            end;
        end;
    end;
end;

answer = sum(decrypt);