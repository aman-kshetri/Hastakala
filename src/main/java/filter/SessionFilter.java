package filter;

import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class SessionFilter implements Filter {

    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/", "/index.jsp", "/auth/login", "/auth/register", "/views/common/login.jsp", "/views/common/register.jsp"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void destroy() {
        // No cleanup required
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (isPublicPath(path)) {
            chain.doFilter(req, res);
            return;
        }

        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (path.startsWith("/admin") && (user == null || !"ADMIN".equals(user.getRole()))) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        if ((path.startsWith("/cart") || path.startsWith("/checkout") || path.startsWith("/customer"))
                && (user == null || !"CUSTOMER".equals(user.getRole()))) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // If none of the above matched, proceed
        chain.doFilter(req, res);
    }


    private boolean isPublicPath(String path) {
        return PUBLIC_PATHS.stream().anyMatch(path::equals)
                || path.startsWith("/css") || path.startsWith("/images") || path.startsWith("/js");
    }
}
