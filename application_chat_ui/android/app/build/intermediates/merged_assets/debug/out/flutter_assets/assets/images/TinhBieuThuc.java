import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class TinhBieuThuc {
    private static int priority(char c)
    {
        if (c=='-' || c=='+')
            return 1;
        if (c=='*' || c=='/')
            return 2;
        if (c=='^')
            return 3;
        return 0;
    }

    private static boolean isOperator(char c)
    {
        if (c=='+' || c=='-' || c=='/' || c=='*')
            return true;
        return false;
    }

    private static String toPostfix(String value, List<Double> so)
    {
        char[] s = value.toCharArray();
        StringBuilder rs= new StringBuilder();
        Stack<Character> sta = new Stack<>();
        for (int i=0;i<s.length;i++)
        {
            StringBuilder temp= new StringBuilder();
            while (s[i]>='0' && s[i] <='9')
            {
                temp.append(s[i]);
                i++;
                if (i == s.length)
                    break;
            }
            if (!temp.toString().equals(""))
            {
                so.add(Double.valueOf(temp.toString()));
                rs.append("1");
            }
            if (i == s.length)
                break;
            if (s[i]=='(')
                sta.push(s[i]);
            else
            {
                if (s[i]==')')
                {
                    while (!sta.empty() && sta.lastElement()!='(')
                    {
                        rs.append(sta.pop());
                        sta.pop();
                    }
                    if (!sta.empty() && sta.lastElement()=='(')
                        sta.pop();
                }
                else
                {
                    while (!sta.empty() && priority(s[i]) <= priority(sta.lastElement()))
                    {
                        rs.append(sta.lastElement());
                        sta.pop();
                    }
                    if (s[i]!='\0')
                        sta.push(s[i]);
                }
            }
        }
        while (!sta.empty() && sta.lastElement()!='(')
        {
            rs.append(sta.lastElement());
            sta.pop();
        }
        System.out.println(rs);
        return rs.toString();
    }

    private static double result(String postfix, List<Double> so) {
        char[] s = postfix.toCharArray();
        Stack<Double> sta = new Stack<>();
        int j=0;
        for (int i=0;i<s.length;i++)
            if (isOperator(s[i]))
            {
                double s1 = sta.pop();
                double s2 = sta.pop();
                switch (s[i])
                {
                    case '-':
                        sta.push(s2-s1);
                        break;
                    case '+':
                        sta.push(s2+s1);
                        break;
                    case '*':
                        sta.push(s2*s1);
                        break;
                    case '/':
                        sta.push(s2/s1);
                        break;
                    default:
                        break;
                }
            }
            else
            {
                sta.push(so.get(j));
                j++;
            }
        return sta.lastElement();
    }

    public static void main(String[] args) {
        List<Double> so = new ArrayList<>();
        String postfix = toPostfix("3+5*5+3*4/3", so);
        System.out.println(postfix);
        System.out.println(so.toString());
        System.out.println(result(postfix, so));
    }
}
