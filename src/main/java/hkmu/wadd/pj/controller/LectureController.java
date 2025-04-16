package hkmu.wadd.pj.controller;

import org.springframework.stereotype.Controller;

@Controller
public class LectureController {
    /*private final Map<Integer, String> lectures = new ConcurrentHashMap<>();

    public LectureController() {
        this.lectures.put(1, "HelloWorld");
        this.lectures.put(2, "ByeWorld");
        this.lectures.put(3, "Login/Logout");
        this.lectures.put(4, "2nd last Lecture");
        this.lectures.put(5, "Last Lecture");
    }

    @GetMapping("/lectures")
    public String showLectures(Model model) {
        model.addAttribute("lectures", lectures);
        return "lecture";
    }

    @PostMapping("/addLecture")
    public String addLecture(@RequestParam("lectureId") int id, @RequestParam("lectureTitle") String title) {
        lectures.put(id, title);
        System.out.println(lectures.get(id));
        return "redirect:/lectures";
    }*/

    /*private void addLecture(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (Exception e) {
            response.sendRedirect("shop");
            return;
        }

        HttpSession session = request.getSession();
        if (session.getAttribute("cart") == null)
            session.setAttribute("cart", new ConcurrentHashMap<>());

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart
                = (Map<Integer, Integer>) session.getAttribute("cart");
        if (!cart.containsKey(productId))
            cart.put(productId, 0);
        cart.put(productId, cart.get(productId) + 1);
        System.out.println(productId + " " + cart.get(productId));

        response.sendRedirect("shop?action=viewCart");
    }*/

    /*@GetMapping("/lectures")
    public ModelAndView showLectures() {
        Map<Integer, String> lectures = new HashMap<>();
        // Add lecture data to the map
        lectures.put(1, "HelloWorld");
        lectures.put(2, "ByeWorld");
        lectures.put(3, "Login/Logout");
        lectures.put(4, "2nd last Lecture");
        lectures.put(5, "Last Lecture");

        ModelAndView modelAndView = new ModelAndView("lecture");
        modelAndView.addObject("lectures", lectures);
        System.out.println(modelAndView.getModel());
        return modelAndView;
    }*/
}
